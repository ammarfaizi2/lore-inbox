Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbSK0TND>; Wed, 27 Nov 2002 14:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbSK0TND>; Wed, 27 Nov 2002 14:13:03 -0500
Received: from [81.2.122.30] ([81.2.122.30]:51972 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S264697AbSK0TNC>;
	Wed, 27 Nov 2002 14:13:02 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200211271931.gARJVFiG000261@darkstar.example.net>
Subject: Re: Tyan 2466, 2468 BIOS setting
To: timm@fnal.gov (Steven Timm)
Date: Wed, 27 Nov 2002 19:31:15 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0211271302250.5024-100000@boxer.fnal.gov> from "Steven Timm" at Nov 27, 2002 01:08:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In a number of boards with Phoenix BIOS including
> the Tyan S2466 and S2468, there is a setting in the BIOS
> for "Large Disk Access Mode", the available settings are
> "DOS" and "Other".  Tyan docs suggest selecting "other".
> 
> These boards use the AMD 760MPX chipset. (dmesg output is below).
> My question...is anyone aware of (1) does the kernel look
> at this BIOS option at all, and if so (2) could having
> it set to DOS instead of Other lead to any
> data corruption?

The option almost certainly changes the translated geometry presented
to the OS via the BIOS.

The only times this is likely to be an issue with Linux is:

1. Installing bootloaders
2. Editing the partition table with FDISK

For more information, have a look at:

http://www.tldp.org/HOWTO/Large-Disk-HOWTO.html

specifically:

http://www.tldp.org/HOWTO/Large-Disk-HOWTO-9.html

John.
