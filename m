Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317879AbSG2AXA>; Sun, 28 Jul 2002 20:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317907AbSG2AXA>; Sun, 28 Jul 2002 20:23:00 -0400
Received: from h-64-105-136-34.SNVACAID.covad.net ([64.105.136.34]:25774 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317879AbSG2AW7>; Sun, 28 Jul 2002 20:22:59 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 28 Jul 2002 17:26:00 -0700
Message-Id: <200207290026.RAA00298@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org, martin@dalecki.de
Subject: cli/sti removal from linux-2.5.29/drivers/ide?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.5.29/drivers/ide has a bunch of calls to cli, sti
and restore_flags.  Documentation/cli-sti-removal.txt describes how
these routines have been removed from the multiprocessor versions of
linux-2.5.29.  Because IDE is such a commonly used subsystem and
because 2.5.29 has been available for almost two days now, I thought
I ought to ask if someone has already made the changes.

	I have not seen any new IDE patches on lkml since 2.5.29 was
released, nor have I seen any other IDE patches that fix this.  Sorry
if I missed a message about it.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
