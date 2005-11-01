Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbVKAAR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbVKAAR7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 19:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbVKAAR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 19:17:59 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:7345 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964876AbVKAAR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 19:17:58 -0500
Date: Tue, 1 Nov 2005 01:17:50 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: ak@suse.de, rmk+lkml@arm.linux.org.uk, torvalds@osdl.org,
       tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
In-Reply-To: <20051031160557.7540cd6a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0511010109100.1386@scrub.home>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
 <20051031001647.GK2846@flint.arm.linux.org.uk> <20051030172247.743d77fa.akpm@osdl.org>
 <200510310341.02897.ak@suse.de> <Pine.LNX.4.61.0511010039370.1387@scrub.home>
 <20051031160557.7540cd6a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 31 Oct 2005, Andrew Morton wrote:

> Roman Zippel <zippel@linux-m68k.org> wrote:
> >
> > Here is a different kind of non trivial regression on a common platform:
> > 
> > $ ll -S /boot/ | grep ...
> > -rw-r--r--  1 root root 1518317 2005-11-01 00:38 vmlinuz-2.6.14
> > -rw-r--r--  1 root root 1506432 2005-08-30 00:36 vmlinuz-2.6.13
> > -rw-r--r--  1 root root 1451154 2004-12-26 16:54 vmlinuz-2.6.10
> > -rw-r--r--  1 root root 1432032 2005-06-26 03:50 vmlinuz-2.6.12
> > -rw-r--r--  1 root root 1413888 2004-06-21 18:33 vmlinuz-2.6.7
> > -rw-r--r--  1 root root 1394801 2004-05-17 22:14 vmlinuz-2.6.5
> > -rw-r--r--  1 root root 1390233 2004-05-18 01:54 vmlinuz-2.6.6
> > -rw-r--r--  1 root root 1315050 2003-09-12 22:10 vmlinuz-2.6.0-test5
> > -rw-r--r--  1 root root 1280189 2003-06-06 01:00 vmlinuz-2.5.70
> > -rw-r--r--  1 root root  918663 2002-11-11 22:42 vmlinuz-2.5.47
> > -rw-r--r--  1 root root  887758 2004-02-19 01:24 vmlinuz-2.4.25
> > -rw-r--r--  1 root root  883868 2003-12-20 21:02 vmlinuz-2.4.23
> 
> What does size(1) say?

This is already stripped and compressed, so it's not directly available.

> Are you sure these kernels are feature-equivalent?

Pretty much, on this machine I generally only include what I need, so only 
a few drivers were added, I even have KALLSYMS disabled.

bye, Roman
