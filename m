Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263300AbTJKNRq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 09:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbTJKNRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 09:17:46 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:31988 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S263300AbTJKNRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 09:17:44 -0400
Message-ID: <26cb01c38ff9$f6251580$5cee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <jamagallon@able.es>, <linux-kernel@vger.kernel.org>
Subject: Re: ACPI year blacklist
Date: Sat, 11 Oct 2003 22:16:02 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:

> I have and (oldie...) SuperMicro P6DGU mobo with ACPI, but the kernel says
> it is too old (before 99, I think...).

If you think your BIOS's ACPI will work, you can add this to your boot
command:
  acpi=force

Of course if it doesn't work then take that back off.

> Why are this BIOSes blacklisted ?

I agree with Zwane Mwaikambo's answer as to why, but I think that 1999 is
likely to be safe.  1998 was dodgy.

By the way, since Mr. Mwaikambo spoke of Monopolysoft systems, I'll add a
bit.  Windows 98 can be switched between ACPI and APM after installing,
though it probably requires multiple reboots (one reboot to load one of the
newly selected drivers and additional reboots to load drivers for redetected
devices further down the chain).  For Windows 2000 and XP you can force a
selection at the beginning of installing, using a poorly documented
technique, but they cannot be switched afterwards.  For Windows 2000 and XP,
if the installer doesn't get forced, it checks lists of known good BIOSes
and known bad BIOSes, and then goes by date for BIOSes that aren't on either
list.  But I think they default to assuming 1999 was good, since Windows
2000 was essentially completed in 1999.

