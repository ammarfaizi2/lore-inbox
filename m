Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267155AbTBDNyz>; Tue, 4 Feb 2003 08:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267263AbTBDNyz>; Tue, 4 Feb 2003 08:54:55 -0500
Received: from [205.205.44.10] ([205.205.44.10]:60940 "EHLO
	sembo111.teknor.com") by vger.kernel.org with ESMTP
	id <S267155AbTBDNyy>; Tue, 4 Feb 2003 08:54:54 -0500
Message-ID: <5009AD9521A8D41198EE00805F85F18F219C28@sembo111.teknor.com>
From: "Isabelle, Francois" <Francois.Isabelle@ca.kontron.com>
To: high-res-timers-discourse@lists.sourceforge.net,
       "'george@mvista.com'" <george@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: High-Res-Timers: Unexpected "lock" during "Calibrating delay loop
	"
Date: Tue, 4 Feb 2003 09:04:22 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	we are having an unexpected problem with the HR patch( regardless of
the patch you sent which compiled just fine ). The board uses a 486DX cpu,
so there is no support for TSC nor ACPI, the only thing we have is the PIT. 

Without highres, the kernel boots properly, with highres enabled, the kernel
passes "time_init()" put it hangs in "calibrate_loop() , ( I though it hung
for real, but it get passed the loop after a while) " 

Seems like the tick is VERY SLOW..

The PIT has been tested on this board, and without HR, the kernel boots fine
... if you have any hints, they would be welcome.

The keyboard detection routine timeouts so the system is quiet unuseable and
I can't get the calibration results yet.


Frank



