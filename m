Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270841AbRHNVDd>; Tue, 14 Aug 2001 17:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270854AbRHNVD0>; Tue, 14 Aug 2001 17:03:26 -0400
Received: from demai05.mw.mediaone.net ([24.131.1.56]:43432 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S270841AbRHNVDM>; Tue, 14 Aug 2001 17:03:12 -0400
Message-Id: <200108142103.f7EL3Nh08273@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: Paul Buder <paulb@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: tmpfs works! was Large ramdisk crashes 2.4.8
Date: Tue, 14 Aug 2001 17:03:40 -0400
X-Mailer: KMail [version 1.3]
In-Reply-To: <Pine.LNX.4.33.0108141350340.15748-100000@shell1.aracnet.com>
In-Reply-To: <Pine.LNX.4.33.0108141350340.15748-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 August 2001 04:52 pm, Paul Buder wrote:
> swapoff -a
> mount -t tmpfs -osize=35M /dev/shm1 /mnt1
> mount -t tmpfs -osize=35M /dev/shm2 /mnt2
> dd if=/dev/zero of=/mnt1/junk bs=1024000 count=100
> dd if=/dev/zero of=/mnt2/junk bs=1024000 count=100
>
> It seems to work but I'm a little worried about the /dev/shm1 and 2.
> It doesn't seem to matter if they even exist or not, they don't seem to
> do anything.  Is this just placeholder candy for fstab and the mount
> command, or am I missing something?

Yes, it's just a placeholder.  I use 'tmpfs' as the device on here.

	-- Brian
