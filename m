Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266160AbSLOBCp>; Sat, 14 Dec 2002 20:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266173AbSLOBCp>; Sat, 14 Dec 2002 20:02:45 -0500
Received: from smtp-server2.tampabay.rr.com ([65.32.1.39]:64664 "EHLO
	smtp-server2.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S266160AbSLOBCo>; Sat, 14 Dec 2002 20:02:44 -0500
From: "Scott Robert Ladd" <scott@coyotegulch.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel for Pentium 4 hyperthreading?
Date: Sat, 14 Dec 2002 20:11:45 -0500
Message-ID: <FKEAJLBKJCGBDJJIPJLJMEGPDLAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20021215005654.GE27658@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I'm going bald even faster than usual.

I've just received a new computer based on a 2.8 GHz Pentium 4 with
hyper-threading enabled. Yes, HT is enabled in the BIOS; yes, /proc/cpuinfo
shows the 'ht' flag; yes, I've compiled 2.4.20 (stock) with SMP and ACPI
enabled.

No, it doesn't work. cat /proc/cpuinfo reports a single CPU.

I've also tried a 2.5.51 kernel -- and it, indeed, does find "both"
processors, listing them in cpuinfo as siblings. Looking at the boot logs,
2.5.51 seems to work just fien with my CPU.

For many reasons, I'd prefer to be running the 2.4.20 kernel (if nothing
else, I'm having trouble getting loadable modules -- the nVidia drivers for
one -- to work on 2.5.51.)

Can 2.4.20 handle a Pentium 4 (not Xeon, mind you) with HT? What could I be
missing in my kernel build?

What is especially frustrating is that the factory-installed Windows XP had
no trouble at all using the HT-enable P4 (until I sent WinXP to the great
bit-bucket in the sky).

Thanks in advance.

..Scott

