Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315539AbSGFOrB>; Sat, 6 Jul 2002 10:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315593AbSGFOrA>; Sat, 6 Jul 2002 10:47:00 -0400
Received: from ares.kos.net ([199.246.2.117]:21960 "HELO ares.kos.net")
	by vger.kernel.org with SMTP id <S315539AbSGFOrA>;
	Sat, 6 Jul 2002 10:47:00 -0400
Message-ID: <004201c224fc$4b828a40$0a00000a@kos.net>
From: "Steve Cole" <coles@vip.kos.net>
To: <linux-kernel@vger.kernel.org>
Subject: Follow-up to Dual Athlon XP MP board problems
Date: Sat, 6 Jul 2002 10:49:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears - though it is still too early to tell - that my problems with
the dual Athlon XP MP system has to do with something called "slew rate".
There is zero documentation on this feature in the motherboard manual, and
setting it to "auto" is what was causing the problem.

Apparently for XP processors, the "slew rate" must be set to "1".  So far
this has cleaned up the stability problems, and the 2.4.19.x kernel is
supporting the hardware in the box.  Speaking of 2.4.19, I'm looking forward
eagerly for it to be nailed together.

