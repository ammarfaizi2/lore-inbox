Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277228AbRJIOBq>; Tue, 9 Oct 2001 10:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277235AbRJIOBh>; Tue, 9 Oct 2001 10:01:37 -0400
Received: from sushi.toad.net ([162.33.130.105]:39836 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S277228AbRJIOB2>;
	Tue, 9 Oct 2001 10:01:28 -0400
Subject: sysctl interface to bootflags?
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 09 Oct 2001 10:01:27 -0400
Message-Id: <1002636089.953.115.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I've said, I think it would be nice to have /proc
control over two boot flags: the DIAG bit (which switches
on (1) and off (0) the BIOS diagnostics) and the PnP-OS bit
(which switches on (0) and off (1) PnP BIOS device configuration).

Would it be a good idea to do this using the sysctl infrastructure?
If so, can someone please suggest an appropriate pathname for
the flag files?  How about "/proc/sys/BIOS/bootflags/diagnostics"
and "/proc/sys/BIOS/bootflags/PnP-OS" ?

If this is a bad idea, someone please stop me before I waste my
time implementing it.

--
Thomas

