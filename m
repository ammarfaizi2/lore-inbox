Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbSKMTjQ>; Wed, 13 Nov 2002 14:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262385AbSKMTjQ>; Wed, 13 Nov 2002 14:39:16 -0500
Received: from alpha.ek3.com ([129.100.142.170]:16653 "EHLO alpha.ek3.com")
	by vger.kernel.org with ESMTP id <S262207AbSKMTjP>;
	Wed, 13 Nov 2002 14:39:15 -0500
Message-ID: <3FF2458E5C16B44AA6807F990CBE63DA049839@alpha.ek3.com>
From: Dan Steele <dan@EK3.com>
To: "'Bill Davidsen'" <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: make distclean and make dep??
Date: Wed, 13 Nov 2002 14:38:33 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>When I do a "make distclean" in a tree, should not that roll it back to a 
>clean empty tree? I noticed that when I did that no work was done by "make 
>dep" in the rebuild.
>Also noted, somewhere between 2.5.45 and 2.5.46 distclean vanished from 
>"make help." It's really useful to have distclean work to build patched 
>kernels for distribution, hopefully this is an oversight and not a new 
>policy.
I've also noticed make rpm fails to link some stuff and craps out, around

arch/i386/kernel/built-in.o: In function `fix_broken_hp_bios_irq9':

which is odd because a make bzImage links it fine...

Dan.
