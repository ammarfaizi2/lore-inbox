Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265504AbUAZEL5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 23:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265505AbUAZEL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 23:11:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:64946 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265461AbUAZELy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 23:11:54 -0500
Date: Sun, 25 Jan 2004 20:12:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Walt H <waltabbyh@comcast.net>
Cc: linux-kernel@vger.kernel.org, jik@kamens.brookline.ma.us,
       linux-raid@vger.kernel.org
Subject: Re: MD Oops on boot with 2.6.2-rc1-mm3
Message-Id: <20040125201206.246b7f86.akpm@osdl.org>
In-Reply-To: <40146B68.6070007@comcast.net>
References: <40146B68.6070007@comcast.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Walt H <waltabbyh@comcast.net> wrote:
>
> > There appears to be a dud raid patch in -mm.  It'll be one of the md-*
> > patches.
> > 
> > If you have time, could you work out which one?  Ones to start with might be
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc1/2.6.2-rc1-mm3/ \
> > broken-out/md-02-preferred_minor-fix.patch
> > 
> > and
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc1/2.6.2-rc1-mm3/ \
> > broken-out/md-06-allow-partitioning.patch
> > 
> > 
> 
> I had a repeatable oops that sounds identical to what Jonathan
> originally reported. Backing out md-06-allow-partitioning.patch fixed
> the oops at boot for me. Thanks,

Thanks.  md-06 and md-07 are in for a bit of a rethink anyway...
