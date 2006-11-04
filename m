Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbWKDJue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbWKDJue (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 04:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbWKDJue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 04:50:34 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:33000 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S965100AbWKDJud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 04:50:33 -0500
Date: Sat, 4 Nov 2006 10:50:05 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "lkml-2006i-ticket@limcore.pl" <lkml-2006i-ticket@limcore.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Simple module for 2.6 request?
In-Reply-To: <454C1F84.9010601@limcore.pl>
Message-ID: <Pine.LNX.4.61.0611041043380.6189@yvahk01.tjqt.qr>
References: <454C1F84.9010601@limcore.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>how to by hand build a module.

Compilation has too many flags and too many steps to be reasonably done 
by hand. Unlike *cough* BSD or Solaris, the Linux kernel makefile system 
is designed to reasonably support external modules using all the 
necessary parameters the kernel you are compiling for needs. You know, I 
always get a shudder when I have to think of Solaris not having 
MODVERSIONS or even VERMAGIC -- it is dangerous because it allows you to 
build stuff that can fubar more easily.

>gcc -o foo.c -ko foo.ko -DMODULE -D__KERNEL__
>-I/usr/src/kernel-headers-directory/include/

gcc: unrecognized option '-ko'

>How to add them by hand (not using all the big Makefiles normally
>included in kernel tree)?

Who said they are big? Look at 
http://jengelh.hopto.org/f/oops_ko.tar.bz2 for a _really_ simple module.


	-`J'
-- 
