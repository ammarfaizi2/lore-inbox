Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288019AbSBIWOG>; Sat, 9 Feb 2002 17:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288028AbSBIWN4>; Sat, 9 Feb 2002 17:13:56 -0500
Received: from bs1.dnx.de ([213.252.143.130]:64935 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S288019AbSBIWNn>;
	Sat, 9 Feb 2002 17:13:43 -0500
Date: Sat, 9 Feb 2002 23:13:15 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: New version of AMD Elan patch available
Message-ID: <Pine.LNX.4.33.0202092306460.31782-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A new version of the AMD Elan patch is available on

  http://www.pengutronix.de/software/elan_en.html

This patch against 2.4.18-pre9 - as the last ones as well - consists only
of a bugfix for the serial driver. All other stuff has been merged into
the mainstream kernel so far. The implementation of the fix has been
changed according to a suggestion by Theodore Ts'o in this revision.

If you have an AMD Elan processor (SC400, SC410, SC520) please test this
fix extensively and send me bug reports. You might also want to test it if
you don't have this special hardware, as the patch now does also affect
the normal serial driver.

On my todo list is the fix for the /proc/ioports resources which is
currently not part of the patch as well as a cpufreq driver.

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+

