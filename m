Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316750AbSGBLdZ>; Tue, 2 Jul 2002 07:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSGBLdY>; Tue, 2 Jul 2002 07:33:24 -0400
Received: from skiathos.physics.auth.gr ([155.207.123.3]:17116 "EHLO
	skiathos.physics.auth.gr") by vger.kernel.org with ESMTP
	id <S316750AbSGBLdX>; Tue, 2 Jul 2002 07:33:23 -0400
Date: Tue, 2 Jul 2002 14:35:33 +0300 (EET DST)
From: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
To: Bongani <bonganilinux@mweb.co.za>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: EXT3 errors
In-Reply-To: <1025583346.3267.7.camel@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0207021433140.1168-100000@skiathos.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Jul 2002, Bongani wrote:

> On Mon, 2002-07-01 at 23:38, Andrew Morton wrote:
> > Bongani wrote:
> > > Jul  1 04:02:14 localhost kernel: EXT3-fs error (device ide0(3,70)):
> > > ext3_new_block: Allocating block in system zone - block = 32802
> > Your filesystem is wrecked.  Did you get some I/O errors?
>
> I found these from the day before
>
> Jun 30 12:31:00 localhost kernel: hdb: dma_intr: status=0x51 {DriveReady
> SeekComplete Error }
> Jun 30 12:31:00 localhost kernel: hdb: dma_intr: error=0x84
> {DriveStatusError BadCRC }

Ah, so you hard disk is wrecked too...

See what badblocks -v on the damaged partition device has to say...

-K.


