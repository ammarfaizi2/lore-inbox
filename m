Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264163AbTKUAGr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 19:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264171AbTKUAGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 19:06:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:13030 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264163AbTKUAFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 19:05:34 -0500
Date: Thu, 20 Nov 2003 16:06:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lawrence Walton <lawrence@the-penguin.otak.com>
Cc: linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>
Subject: Re: Opps on boot 2.6.0-pre9-mm4
Message-Id: <20031120160601.6b1fbd53.akpm@osdl.org>
In-Reply-To: <20031120233006.GA1331@the-penguin.otak.com>
References: <20031120193318.GA5578@the-penguin.otak.com>
	<20031120131945.3cd35911.akpm@osdl.org>
	<20031120233006.GA1331@the-penguin.otak.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lawrence Walton <lawrence@the-penguin.otak.com> wrote:
>
> > Looks like it died inside the machine's BIOS.
> > 
> > Please try reverting the three pnp patches:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-3.patch
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-2.patch
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-1.patch
> > 
> > and let us know?
> > 
> I reverted these and it works great!
> 
> 
> 
> > - Upgrade the bios
> The bios is the latest so updating it would not of been a option.
> 

OK, thanks.   Adam, those pnp patches are suspect...

