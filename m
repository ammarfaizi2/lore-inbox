Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWA0Tai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWA0Tai (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 14:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWA0Tai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 14:30:38 -0500
Received: from mail.gmx.de ([213.165.64.21]:62375 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932486AbWA0Tah convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 14:30:37 -0500
X-Authenticated: #9962044
From: Marc <marvin24@gmx.de>
To: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: patching arm-linux 2.4.18 on sharp zaurus sl-5500
Date: Fri, 27 Jan 2006 20:30:23 +0100
User-Agent: KMail/1.9.1
References: <a76b68304d1cadc77190142ba67324a6@cs.pitt.edu> <20060127143832.GG3673@harddisk-recovery.com>
In-Reply-To: <20060127143832.GG3673@harddisk-recovery.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601272030.24079.marvin24@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Friday 27 January 2006 15:38, vous avez écrit :
> On Fri, Jan 27, 2006 at 09:28:07AM -0500, Lorne J. Leitman wrote:
> > We are a group of researchers at University of Pittbsurgh trying to
> > implement an ad-hoc routing protocol on the Sharp Zaurus 5500 pda.  Our
> > network is running the following environment:
> >       -arm-linux kernel 2.4.18-pxa3-embedix-021129
>
> ncftp /pub/linux/kernel/v2.4 > dir patch-2.4.18.bz2
> -rw-rw-r--    1 536      536       826105   Feb 25  2002   
> patch-2.4.18.bz2
>
> Any particular reason why you're using a 4 year old kernel?
>
> >       -OpenZaurus 3.5.1

as far as I know, OpenZaurus 3.5.4 is comming soon, but the standard kernel is 
still 2.4.18-xyz. The Zaurus 5500 was not ported to newer kernels, because 
the implementation from sharp/lineo was just to ugly. Instead a direct 2.6 
port was started but not finished up to now (see 
http://www.cs.wisc.edu/~lenz/zaurus).
I don't know if netfilter is activated in the OpenZaurus kernels, but you can 
build a kernel yourself and activate it (see www.openzaurus.org and 
http://oe.handhelds.org/cgi-bin/moin.cgi/GettingStarted for the toolchain and 
buildsystem).
Pavel Machek has send some patches recently to lkml for the 2.6 kernel, but I 
don't know what the status is right now.

	marvin

