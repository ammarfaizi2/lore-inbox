Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSKMNmH>; Wed, 13 Nov 2002 08:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbSKMNmH>; Wed, 13 Nov 2002 08:42:07 -0500
Received: from [195.110.114.159] ([195.110.114.159]:30759 "EHLO trinityteam.it")
	by vger.kernel.org with ESMTP id <S261375AbSKMNmG>;
	Wed, 13 Nov 2002 08:42:06 -0500
Date: Wed, 13 Nov 2002 14:51:57 +0100 (CET)
From: <ricci@esentar.trinityteam.it>
To: Freaky <freaky@bananateam.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: PDC20276 Linux driver
In-Reply-To: <1037192260.1501.1.camel@darkstar>
Message-ID: <Pine.LNX.4.21.0211131440310.11123-100000@esentar.trinityteam.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 13 Nov 2002, Freaky wrote:

> I couldn't install slackware at all, even with my home compiled kernel.
> It just doesn't recognize the /dev/ataraid/d?p? drives and tells me
> there are no disks with ext2 filesystems when I try to start setup.

You can simply mount /dev/ataraid/d?p? on /mnt and start  the slackware
installation setup script skipping the selection of the target, the swap
and the lilo configuration; after istallation is completed, you can edit
/etc/fstab and /etc/lilo.conf as you whish.

> You need the ataraid drivers for the pdc don't you?
I compiled the kernel with PDC202XX driver, with ataraid and with FastTrak
ataraid driver.

> How did you compile pdc without ataraid?
I tryed to compile pdc202xx and not ataraid to try to use software raid.
Is this the answer you were lookig for?

In all the cases my pdc20276 hangs after about half a gigabyte written
into any disk.

