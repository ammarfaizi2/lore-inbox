Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbTKIBMn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 20:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTKIBMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 20:12:42 -0500
Received: from [62.67.222.139] ([62.67.222.139]:42985 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S262130AbTKIBMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 20:12:41 -0500
Date: Sun, 9 Nov 2003 02:12:05 +0100
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: Weird partititon recocnising problem in 2.6.0-testX
Message-ID: <20031109011205.GA21914%konsti@ludenkalle.de>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i-ja.1
X-Spam-Score: 3.3
X-Spam-Report: Spam detection software, running on the system "kermit", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	admin@mail.ku-gbr.de for details.
	Content preview:  Hi! I have a PC here with an intel i875p chipset which
	seems not to recognize logical partititions. 2.4.18 (kernel bf24 image)
	boots fine, but i do not get a 2.6.0-test5 or 2.6.0-test9 to boot. I
	compiled all necessary IDE drivers in, IDE, ide disk and piix and such.
	All attempts yield in [...] 
	Content analysis details:   (3.3 points, 10.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.5 RCVD_IN_NJABL_DIALUP   RBL: NJABL: dialup sender did non-local SMTP
	[217.227.70.105 listed in dnsbl.njabl.org]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[Dynamic/Residential IP range listed by]
	[easynet.nl DynaBlock - <http://dynablock.easynet.nl/errors.html>]
	0.1 RCVD_IN_NJABL          RBL: Received via a relay in dnsbl.njabl.org
	[217.227.70.105 listed in dnsbl.njabl.org]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[217.227.70.105 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a PC here with an intel i875p chipset which seems not to recognize
logical partititions. 2.4.18 (kernel bf24 image) boots fine, but i do
not get a 2.6.0-test5 or 2.6.0-test9 to boot.

I compiled all necessary IDE drivers in, IDE, ide disk and piix and
such. All attempts yield in

Kernel Panic: VFS: Unable to mount root fs on hda5

I tried to submit root=0305 and such to pass to it. On my later
investigations I realized that the partition recocnizion seems to fail.

When booting Kernels report

hda: hda1 hda2 <hda5 hda6>

and boot, this one reports only:

hda: hda hda2

So, where are the logical ones?

In "Advanced partition selection" I switched on 
"PC BIOS (MSDOS partition tables) support" but that made no
difference...

hm. what next?

Regards, Konsti

-- 
2.6.0-test6-mm4
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 4:24, 1 user
