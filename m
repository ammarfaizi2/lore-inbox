Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSGLAe5>; Thu, 11 Jul 2002 20:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317951AbSGLAe4>; Thu, 11 Jul 2002 20:34:56 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25359 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314096AbSGLAez>; Thu, 11 Jul 2002 20:34:55 -0400
Subject: Re: Athlon + Athlon optimized kernel => _mmx_mmcpy problems
To: greearb@candelatech.com (Ben Greear)
Date: Fri, 12 Jul 2002 02:01:07 +0100 (BST)
Cc: cs@pixelwings.com (Clemens Schwaighofer),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3D2E235E.1060701@candelatech.com> from "Ben Greear" at Jul 11, 2002 05:31:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17Sonz-0001z8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I had this same problem untill I did a make mrproper and re-built from
> scratch.  Some part of the build system seems to be the problem (make clean
> does not help)

Known problem. Arch and SMP changes are not handled right. This is fixed
in kbuild 2.5 but that isnt merged into 2.4 (and probably wont be) or 
2.5 (where some of the ideas seem to be getting in bit by bit)
