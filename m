Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbUBXXT0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 18:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbUBXXT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 18:19:26 -0500
Received: from 15.Red-80-33-233.pooles.rima-tde.net ([80.33.233.15]:56300 "EHLO
	l0r0") by vger.kernel.org with ESMTP id S262527AbUBXXTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 18:19:20 -0500
Subject: ACPI fail in kernel 2.4.25 and 2.6.3
From: Javier Gonzalez <javi@l0r0.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1077664167.909.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 25 Feb 2004 00:09:27 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Recently I have upgraded my kernel from 2.4.22-AlanCoxPatch. I have an
Acer Travelmate 290LMi laptop (Centrino). All worked well with 2.4.22
but i have problems with new kernels.

With 2.4.25 + cpufreq patch from
ftp://ftp.linux.org.uk/pub/linux/cpufreq/ and a few minutes after boot
(when i try to know battery state with acpi command) i get this "bucle"
error:

Feb 24 23:47:00 localhost kernel: acpi_battery-0195 [1619]
acpi_battery_get_statu: Error evaluating _BST
Feb 24 23:47:01 localhost kernel:  dswload-0279: *** Error: Looking up
[PBST] in namespace, AE_ALREADY_EXISTS
Feb 24 23:47:01 localhost kernel:  psparse-0588 [1626]
ps_parse_loop         : During name lookup/catalog, AE_ALREADY_EXISTS
Feb 24 23:47:01 localhost kernel:  psparse-1120: *** Error: Method
execution failed [\_SB_.PCI0.LPC0.BAT1._BST] (Node c1562528),
AE_ALREADY_EXISTS

I tried with 2.6.3 and y get the same error :-( 

I have twho friends with diferents laptops who have the same problem.

Thank for your help.

-- 
Un saludo:

                            Javier González
                   GNU/Linux registered user #302650


