Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUGCSrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUGCSrX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 14:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265226AbUGCSrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 14:47:23 -0400
Received: from aun.it.uu.se ([130.238.12.36]:65254 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265222AbUGCSrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 14:47:22 -0400
Date: Sat, 3 Jul 2004 20:47:16 +0200 (MEST)
Message-Id: <200407031847.i63IlGcI027349@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: jhudson@cyberspace.org, linux-kernel@vger.kernel.org
Subject: Re: [PACH] updated patch to restore bootsect
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jul 2004 13:20:11 -0400 (EDT), Joshua <jhudson@cyberspace.org> wrote:
>diff -rup linux-2.6.7/arch/i386/boot/bootsect.S
>linux-2.6.7c/arch/i386/boot/bootsect.S
>--- linux-2.6.7/arch/i386/boot/bootsect.S	Tue Jun 15 22:19:23 2004
>+++ linux-2.6.7c/arch/i386/boot/bootsect.S	Fri Jul  2 04:22:08 2004
>@@ -5,12 +5,17 @@
>  *	modified by Bruce Evans (bde)
>  *	modified by Chris Noe (May 1999) (as86 -> gas)
>  *	gutted by H. Peter Anvin (Jan 2003)
>+ *	rewritten by Joshua Hudson (June 2004)

Why?

We got rid of this code for two reasons:
- it didn't work reliably
- normal boot loaders like (recent versions of) syslinux do work
