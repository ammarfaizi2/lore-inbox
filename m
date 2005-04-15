Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbVDOX4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVDOX4I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 19:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVDOX4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 19:56:08 -0400
Received: from smtpout.mac.com ([17.250.248.71]:53496 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262424AbVDOX4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 19:56:01 -0400
In-Reply-To: <b1bc6a0005041515505419ba1e@mail.gmail.com>
References: <8c5d8e66ebfcfe879244a18068544dc3@mac.com> <b1bc6a0005041515505419ba1e@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <92a079f49398da9f068fb9b15eb15101@mac.com>
Content-Transfer-Encoding: 7bit
Cc: LKML kernel <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: SCSI opcode 0x80 and 3ware Escalade 7000 ATA RAID
Date: Fri, 15 Apr 2005 19:55:56 -0400
To: adam radford <aradford@gmail.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 15, 2005, at 18:50, adam radford wrote:
> Make sure you are are using the 3ware character ioctl interface at
> /dev/twe0 (dynamic major, controller number minor) for your
> smartmontools, not /dev/sda.

Hmm, I don't have any /dev/twe* here.  I _do_ have hotplug, udev, etc,
installed, and this is a 2.6 machine, so I'm not sure what could be 
wrong.
How recent was this change?

> The old interface from smartmontools used SCSI_IOCTL_SEND_COMMAND
> ioctls with a special passthru opcode of 0x80 that would get passed
> to the driver.  This interface is deprecated in the driver and the
> kernel.

Ok.  Now if only I could find it.  Is there anyplace in sysfs that I
can check manually to see what the dynamic major is?  I'd like to
try creating the device by hand if I can't get Debian hotplug to see
it.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


