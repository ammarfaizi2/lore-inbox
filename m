Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbSJSGG4>; Sat, 19 Oct 2002 02:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265526AbSJSGG4>; Sat, 19 Oct 2002 02:06:56 -0400
Received: from host194.steeleye.com ([66.206.164.34]:46600 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261840AbSJSGGz>; Sat, 19 Oct 2002 02:06:55 -0400
Message-Id: <200210190612.g9J6Cqu11812@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: James.Bottomley@HansenPartnership.com
Subject: [PATCH] Voyager subarchitecture for 2.5.44
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 19 Oct 2002 01:12:52 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SMP (and UP) support for voyager which is an (up to 32 way) 
SMP microchannel non-PC architecture.

The current patch includes a swap around of the timer code defines (available 
separately at http://linux-voyager.bkbits.net/timer-2.5) and a new 
CONFIG_X86_TRAMPOLINE config option to avoid the trampoline vpath.

The patch (156k) is available here:

http://www.hansenpartnership.com/voyager/files/voyager-2.5.44.diff

And also via bitkeeper at

http://linux-voyager.bkbits.net/voyager-2.5

James Bottomley

