Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbUKSN5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbUKSN5D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 08:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUKSN5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 08:57:03 -0500
Received: from hentges.net ([81.169.178.128]:36028 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S261415AbUKSN4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 08:56:20 -0500
Subject: Re: pci-resume patch from 2.6.7-rc2 breakes S3 resume on some
	machines
From: Matthias Hentges <mailinglisten@hentges.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041119115507.GB1030@elf.ucw.cz>
References: <1100811950.3470.23.camel@mhcln03>
	 <20041119115507.GB1030@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 19 Nov 2004 14:56:17 +0100
Message-Id: <1100872578.3692.7.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 19.11.2004, 12:55 +0100 schrieb Pavel Machek:
> Hi!
> 
> > I'm in the process of debugging S3 on my notebook and found out that I
> > can resume from S3 with every kernel up to (and including) 2.6.7-rc1
> > ( patch-2.6.6-bk8-bk9.bz2 ).
> 
> You can resume and your video works after resume in 2.6.7? Great!

Heh, well no. Video is as dead as it can get :\ No known trick revives
it after a resume . But at least the machine doesn't freeze after S3.


> Okay, patch is way too ugly.

Of course it is :) It's more a proof-óf-concept that pci-resume is
indeed causing the problem. I have no idea how to debug this any
further. In the meantime this patch works for me.

>  You probably should provide resume method
> for your radeon that just does nothing. That should confirm your
> theory, fix the crash, and you'll avoid touching common code with it.

Sorry, that's beyond my abilities. That's why I'm posting here. I'm not
even sure that it's the radeon which is acting up here.
-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian SID. Geek by Nature, Linux by Choice

