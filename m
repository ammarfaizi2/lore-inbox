Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279799AbRKFQoi>; Tue, 6 Nov 2001 11:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279797AbRKFQo2>; Tue, 6 Nov 2001 11:44:28 -0500
Received: from sweetums.bluetronic.net ([66.57.88.6]:41877 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S279788AbRKFQoQ>; Tue, 6 Nov 2001 11:44:16 -0500
Date: Tue, 6 Nov 2001 11:44:14 -0500 (EST)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Dana Lacoste <dana.lacoste@peregrine.com>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: RE: Mylex/Compaq RAID controller placement in config
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2863@ottonexc1.ottawa.loran.com>
Message-ID: <Pine.GSO.4.33.0111061138030.17287-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001, Dana Lacoste wrote:
>For example : All of the SCSI devices are block devices,
>aren't they?  So how come they're not under "block devices"
>in the menu?

Nope.  They present a hardware interface to various devices.  Some of those
devices are block devices, but not all of them (eg. tape drives, scanners,
printers, SCSI-IP :-))

>All of the devices under "block devices" are storage controllers
>(or ways of accessing storage in linux) so how come they're not
>listed as such in the menuconfig options?

Because they aren't.  Alot of the structure is historical... 15 years ago,
all you could plug into IDE were block devices and there you are.

>and then you hit the whole I20 problem.  Half my raid controllers
>aren't under either of those two menus.

Heh, well, I2O is it's own problem. (And it's eye-two-oh, not zero.) In
most respects, I2O is more like "pci support" than a "driver" per se. (It's
just one more layer.)

--Ricky


