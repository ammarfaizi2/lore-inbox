Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315375AbSGGKzC>; Sun, 7 Jul 2002 06:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315419AbSGGKzC>; Sun, 7 Jul 2002 06:55:02 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:64992 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S315375AbSGGKzB>;
	Sun, 7 Jul 2002 06:55:01 -0400
Date: Sun, 7 Jul 2002 12:57:37 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200207071057.MAA17209@harpo.it.uu.se>
To: fbujanic@fikus.com
Subject: Re: PROBLEM: floppy oops in 2.5.25
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jul 2002 22:27:23 -0400 (EDT), Filip J. Bujanic wrote:
>[1.] One line summary of the problem:
>	accessing floppy drive oopses 2.5.25 kernel

If you had searched the LKML archives you would soon have found out
that the floppy driver is known to be broken since 2.5.13.

A partial fix exists which eliminates the oopses and allows raw
/dev/fd0 accesses to work; VFS accesses to mounted floppies are
still broken however. You can get it from the -dj patch or from
http://www.csd.uu.se/~mikpe/linux/patches/2.5/patch-fix-floppy-2.5.25

/Mikael
