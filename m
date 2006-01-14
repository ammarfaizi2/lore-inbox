Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWANWTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWANWTA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWANWTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:19:00 -0500
Received: from mx3.mail.ru ([194.67.23.149]:20856 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S1751310AbWANWS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:18:59 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: acpi-devel@lists.sourceforge.net
Subject: cannot unload acpi-cpufreq
Date: Sun, 15 Jan 2006 01:18:56 +0300
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601150118.57542.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Running 2.6.15 vanilla. I am unable to unload acpi-cpufreq - I always get 

{pts/1}% sudo rmmod acpi_cpufreq
ERROR: Module acpi_cpufreq is in use

I do not see, how can I actually "release" it. Also, the reason I need to 
unload it - I am testing alternative CPU frequency driver and would like to 
avoid reboot when switching. This driver unloads just fine (it is written by 
me and contains the minimal set of functions).

Ay idea?

regards

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDyXjRR6LMutpd94wRAnVfAJ0Tbrq/NyPyFFG/wsB+mnaOSPpIrgCfeRqs
aJ1ieQrVCpyytz8R+yxgnXM=
=a2Kj
-----END PGP SIGNATURE-----
