Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbTKQCoc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 21:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTKQCoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 21:44:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:64698 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263267AbTKQCob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 21:44:31 -0500
Date: Sun, 16 Nov 2003 18:49:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Gawain Lynch <gawain@freda.homelinux.org>
Cc: prakashpublic@gmx.de, linux-kernel@vger.kernel.org, cat@zip.com.au
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
Message-Id: <20031116184925.43c8b481.akpm@osdl.org>
In-Reply-To: <1069035604.1916.3.camel@frodo.felicity.net.au>
References: <20031116192643.GB15439@zip.com.au>
	<3FB7DCF9.5090205@gmx.de>
	<20031116134231.763fc5ed.akpm@osdl.org>
	<1069035604.1916.3.camel@frodo.felicity.net.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gawain Lynch <gawain@freda.homelinux.org> wrote:
>
> On Mon, 2003-11-17 at 08:42, Andrew Morton wrote:
> > Two things to try, please:
> > 
> > a) Is the problem from Linus's tree?  Try 2.6.0-test9 plus 
> > 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm3/broken-out/linus.patch
> > 
> > b) The only significant scheduler change in mm3 was 
> > 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm3/broken-out/context-switch-accounting-fix.patch
> > 	
> >    So please try -mm3 with the above patch reverted with
> > 
> > 	patch -R -p1 < context-switch-accounting-fix.patch
> > 
> 
> Hi Andrew,
> 
> This is also easily reproducible here with just a kernel compile.
> 
> I have tried both a) and b) with b) not changing anything, but a) seems
> to work...  Anything more to try?
> 

Your report has totally confused me.  Are you saying that the jerkiness is
caused by linus.patch?  Or not?  Pleas try again ;)

