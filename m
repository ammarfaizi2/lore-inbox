Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318722AbSHQUKl>; Sat, 17 Aug 2002 16:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318727AbSHQUKl>; Sat, 17 Aug 2002 16:10:41 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:37874 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318722AbSHQUKk>; Sat, 17 Aug 2002 16:10:40 -0400
Subject: Re: 2.4.20-pre2-ac3 oops
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020816181957.GA14157@ulima.unil.ch>
References: <20020816181957.GA14157@ulima.unil.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Aug 2002 21:13:36 +0100
Message-Id: <1029615216.4809.55.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PCI: Unable to reserve I/O region #1:8@0 for device 00:1f.1
> Trying to free nonexistent resource <00000000-00000007>
> Trying to free nonexistent resource <00000000-00000003>
> Trying to free nonexistent resource <00000000-00000007>
> Trying to free nonexistent resource <00000000-00000003>
> Trying to free nonexistent resource <0000fc00-0000fc0f>
> Trying to free nonexistent resource <20000000-200003ff>

These are a bit disturbing to say the least. If you boot without ACPI
and PnPBIOS do those vanish. I think thats unrelated however but is
something wrong

> hda: IC35L120AVVA07-0, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
> ide1 at 0x170-0x177,0x376 on irq 15

> Should I sent other tings?

An lspci -v and info on what is attached to each ide controller would be
good

