Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbTGMLue (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 07:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270235AbTGMLud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 07:50:33 -0400
Received: from mailgate1.sover.net ([209.198.87.60]:13789 "EHLO
	mailgate1.sover.net") by vger.kernel.org with ESMTP id S265069AbTGMLuc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 07:50:32 -0400
Date: Sun, 13 Jul 2003 07:55:59 -0400 (EDT)
From: David G Hamblen <dave@AFRInc.com>
Reply-To: dave@AFRInc.com
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Dell Inspiron with 2.5.75 and ACPI, backlight issues
Message-ID: <Pine.LNX.4.44.0307130714570.692-100000@puppy.afrinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With a Dell Inspiron 8100, running 2.5.75 with ACPI compiled in with sleep
states enabled, things work pretty much as expected except that the
backlight stays on when the system is first suspended to RAM.  Kind of
looks like the meaning of some bit is reversed.  It doesn't matter whether
I'm running X or not.

root#echo 3 > /proc/acpi/sleep
system suspends, screen goes white, backlight stays on.

<Hit power button>
 system comes up, backlight goes off!  At this point I can telnet (ssh) in
from another machine, etc; but the backlight stays off.  I can cycle the
sleep/power sequence many times, but the backlight stays off.



			Dave



