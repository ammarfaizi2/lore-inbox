Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbVKAAF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbVKAAF6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 19:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbVKAAF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 19:05:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31108 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964906AbVKAAF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 19:05:57 -0500
Date: Mon, 31 Oct 2005 16:05:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: ak@suse.de, rmk+lkml@arm.linux.org.uk, torvalds@osdl.org,
       tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-Id: <20051031160557.7540cd6a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0511010039370.1387@scrub.home>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	<20051031001647.GK2846@flint.arm.linux.org.uk>
	<20051030172247.743d77fa.akpm@osdl.org>
	<200510310341.02897.ak@suse.de>
	<Pine.LNX.4.61.0511010039370.1387@scrub.home>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
>
> Here is a different kind of non trivial regression on a common platform:
> 
> $ ll -S /boot/ | grep ...
> -rw-r--r--  1 root root 1518317 2005-11-01 00:38 vmlinuz-2.6.14
> -rw-r--r--  1 root root 1506432 2005-08-30 00:36 vmlinuz-2.6.13
> -rw-r--r--  1 root root 1451154 2004-12-26 16:54 vmlinuz-2.6.10
> -rw-r--r--  1 root root 1432032 2005-06-26 03:50 vmlinuz-2.6.12
> -rw-r--r--  1 root root 1413888 2004-06-21 18:33 vmlinuz-2.6.7
> -rw-r--r--  1 root root 1394801 2004-05-17 22:14 vmlinuz-2.6.5
> -rw-r--r--  1 root root 1390233 2004-05-18 01:54 vmlinuz-2.6.6
> -rw-r--r--  1 root root 1315050 2003-09-12 22:10 vmlinuz-2.6.0-test5
> -rw-r--r--  1 root root 1280189 2003-06-06 01:00 vmlinuz-2.5.70
> -rw-r--r--  1 root root  918663 2002-11-11 22:42 vmlinuz-2.5.47
> -rw-r--r--  1 root root  887758 2004-02-19 01:24 vmlinuz-2.4.25
> -rw-r--r--  1 root root  883868 2003-12-20 21:02 vmlinuz-2.4.23

What does size(1) say?

Are you sure these kernels are feature-equivalent?
