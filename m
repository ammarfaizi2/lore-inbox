Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTGRWbc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 18:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271893AbTGRWab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 18:30:31 -0400
Received: from u194-119-236-131.dialup.planetinternet.be ([194.119.236.131]:13572
	"EHLO jebril.pi.be") by vger.kernel.org with ESMTP id S271859AbTGRW1r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 18:27:47 -0400
Message-Id: <200307182239.h6IMdhM6008840@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test1 + matroxfb = unuusable VC
Date: Sat, 19 Jul 2003 00:39:43 +0200
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetz,

I'm using (or rather: trying to use) matroxfb on 2.6.0-test1 (2.5.72 had 
the same problems) and am seeing the following:

 - The initial boot console works fine, but all other consoles have 
   scrolling problems. The area to the right of any scrolled text is 
   most often coloured white, whereas it should be black. When using vi, 
   it's even worse: white rectangles all over the place.

 - Right after switching from X to a text console, the fill color is not
   white, but sort of a folded ghost image of part of my X display;

 - Scrolling is not continuous: keep <enter> pushed down, and every so 
   often a jump of about 1/3 of the hight of the screen occurs, combined
   with a few lines that do use the correct black background;

 - Backspacing only works when the cursor is positioned at the end of the 
   command line. Anywhere else the positions to the right of the cursor 
   are not repainted.

I'm using these settings: video=matroxfb:vesa:0x11A,fh:92k,fv:160"

  MCE

