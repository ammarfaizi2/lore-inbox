Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293276AbSCOVZN>; Fri, 15 Mar 2002 16:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293283AbSCOVZD>; Fri, 15 Mar 2002 16:25:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53008 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293276AbSCOVYy>; Fri, 15 Mar 2002 16:24:54 -0500
Subject: Re: [OOPS] Kernel powerdown
To: reality@delusion.de (Udo A. Steinberg)
Date: Fri, 15 Mar 2002 21:40:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel), andrew.grover@intel.com
In-Reply-To: <3C9264EC.CCCBEDD1@delusion.de> from "Udo A. Steinberg" at Mar 15, 2002 10:17:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lzRP-0004jH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> flushing ide devices: hda hdb hde 
> Power down.
> NMI Watchdog detected LOCKUP on CPU0


Looks like the ACPI code is simply forgetting to turn off the NMI watchdog
