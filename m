Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315410AbSFXW7F>; Mon, 24 Jun 2002 18:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSFXW7E>; Mon, 24 Jun 2002 18:59:04 -0400
Received: from AMontpellier-205-1-4-20.abo.wanadoo.fr ([217.128.205.20]:40197
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S315410AbSFXW7D>; Mon, 24 Jun 2002 18:59:03 -0400
Subject: 2.4.19-pre10-ac2: APM & ACPI
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 25 Jun 2002 00:59:08 +0200
Message-Id: <1024959550.3208.11.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an SMP Via VP6 mobo. Here is an excerpt from dmesg:

apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
apm: disabled - APM is not SMP safe (power off active).

then:

ACPI: APM is already active, exiting

That's weird, because I left apm only to power off the machine
(otherwise it doesn't), knowing that it wouldn't be enabled because of
the SMP mobo. ACPI should still work.

(OTOH, I finally disabled ACPI because (after compiling without APM) it
appears it randomly freezes or reboots my machine ..)

