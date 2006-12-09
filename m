Return-Path: <linux-kernel-owner+w=401wt.eu-S937669AbWLIUos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937669AbWLIUos (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 15:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937672AbWLIUos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 15:44:48 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:38540 "HELO
	smtp105.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S937669AbWLIUor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 15:44:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:Received:Date:From:To:Subject:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=uv4vvvkmwtsDWFQZ2SMqKzQ+ellxhWIwXvKWFwmMTiRKqJ/j+K1kw7sXsw7hV89tO0+yBrui3Qt3yXFxbLISyI6rvm6hs94GQAoqEmn3j+rwd8hrD9ygMgIdaeW5fiyEBlj64Zf5sXs09qVGpSczRw/wP7zOah1rNa829oASZuA=  ;
X-YMail-OSG: 3gkz5PIVM1kjoPVGSiyrp819V6Au1TTeDdNEHyqDU6kGkA38M8rNhjaM1qXCNunO15X3yCJtBHWiJtOAGtrSBPU_jp6zd2nq_aIFpv.Jj3bSKONbbntE4.RyuWUNUqEgl18TSP0cPM90W.Q-
Date: Sat, 09 Dec 2006 12:44:37 -0800
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.6.19-git] another build fix, header rearrangements (OSK)
Cc: tony@atomide.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061209204437.21B3E1B4A6D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the header file rearrangements broke the build for board-osk.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- osk.orig/arch/arm/mach-omap1/board-osk.c	2006-12-07 23:56:36.000000000 -0800
+++ osk/arch/arm/mach-omap1/board-osk.c	2006-12-08 03:04:01.000000000 -0800
@@ -30,6 +30,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/irq.h>
+#include <linux/interrupt.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
