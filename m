Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271973AbRIMS70>; Thu, 13 Sep 2001 14:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271975AbRIMS7Q>; Thu, 13 Sep 2001 14:59:16 -0400
Received: from 63-151-64-156.hsacorp.net ([63.151.64.156]:58890 "EHLO
	boojiboy.eorbit.net") by vger.kernel.org with ESMTP
	id <S271973AbRIMS7K>; Thu, 13 Sep 2001 14:59:10 -0400
From: chris@boojiboy.eorbit.net
Message-Id: <200109131955.MAA07591@boojiboy.eorbit.net>
Subject: Re: 2.4.9-ac9 APM w/Compaq 16xx laptop...
To: linux-kernel@vger.kernel.org
Date: Thu, 13 Sep 2001 12:55:56 -0700 (PDT)
Cc: J.A.K.Mouw@ITS.TUDelft.NL
In-Reply-To: <20010913091748.A21626@arthur.ubicom.tudelft.nl> from "Erik Mouw" at Sep 13, 2001 09:17:48 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > When my bios is set ACPI=NO, and APM is compiled in:
> > > > A 'shutdown -r' hangs after the "Restarting System" message.  
> > > > Depressing the power switch cause a power off.

> > Here is the APM config:
> > # CONFIG_APM_CPU_IDLE is not set
>     ^^^^^^^^^^^^^^^^^^^
> Any reason why this is not enabled? There's no much use for APM without it.

This is now set  CONFIG_APM_CPU_IDLE=y

> Could you also tell what the kernel thinks about your laptop? It should
> print things like "BIOS Vendor: Phoenix Technologies LTD".

Here is the newly patched dmesg output:

Linux version 2.4.9-ac9 (root@oso) (gcc version 2.95.3 20010315 (release)) #1 Thu Sep 13 10:51:23 PDT 2001
...
Initializing RT netlink socket
DMI 2.2 present.
11 structures occupying 403 bytes.
DMI table at 0x000DC010.
BIOS Vendor: Phoenix Technologies LTD
BIOS Version: 4.06
BIOS Release: 08/16/99
System Vendor: Compaq.
Product Name: Compaq PC.
Version 0F0B.
Serial Number 1V96CLS9D42J.
Board Vendor: Compaq.
Board Name: 0548h.
Board Version: Rev.A.
Asset Tag: No Asset Tag.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
