Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315513AbSG3Sss>; Tue, 30 Jul 2002 14:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315536AbSG3Sss>; Tue, 30 Jul 2002 14:48:48 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:4592 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315513AbSG3Ssr>; Tue, 30 Jul 2002 14:48:47 -0400
Subject: Re: [patch 2/9] 2.5.6 lm_sensors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020729222434.GB15219@elf.ucw.cz>
References: <3D381CD1.6A0B9909@bellsouth.net>
	<1027130877.14314.6.camel@irongate.swansea.linux.org.uk>
	<20020726104640.GD279@elf.ucw.cz>
	<1027694678.13429.40.camel@irongate.swansea.linux.org.uk> 
	<20020729222434.GB15219@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 Jul 2002 21:08:25 +0100
Message-Id: <1028059705.7974.32.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 23:24, Pavel Machek wrote:
> > Given an afternoon someone competent can easily write a worm that
> > destroys every scsi hard disk, almost every PC bios, your IDE firmware,
> > some laptop batteries some USB devices and far more.
> 
> Every scsi harddisk? I do not think *all* of them have upgradable
> firmware.
> 
> Every PC bios? I believe many manufacturers are clever enough to
> require jumper.
> 
> If hardware is so crappy it is possible to kill it ... well ... I
> believe it is at least bugtraq topic.

Pretty much all of them do. They often put the firmware on the disk
platter nowdays rather than on flash.

As to PC BIOSes  - a few boards have jumpers, even fewer use them.

Things are improving with the use of crypto in firmware for drives
(addmitedly mostly to stop people patching the firmware to remove DVD
region protection and other crap folks have been sneaking in) and black
box protection for the bios flash - where a password must be written to
write only registers (with another write only register set to configure
a new password or turn on flash write once the old password is written
to enable)


