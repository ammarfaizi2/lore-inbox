Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316606AbSGBEKq>; Tue, 2 Jul 2002 00:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316604AbSGBEKp>; Tue, 2 Jul 2002 00:10:45 -0400
Received: from starcraft.mweb.co.za ([196.2.45.78]:63914 "EHLO
	starcraft.mweb.co.za") by vger.kernel.org with ESMTP
	id <S316606AbSGBEKo>; Tue, 2 Jul 2002 00:10:44 -0400
Subject: Re: EXT3 errors
From: Bongani <bonganilinux@mweb.co.za>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3D20CBD7.BC184F53@zip.com.au>
References: <1025551456.1587.2.camel@localhost.localdomain> 
	<3D20CBD7.BC184F53@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-1mdk 
Date: 02 Jul 2002 06:15:40 +0200
Message-Id: <1025583346.3267.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-01 at 23:38, Andrew Morton wrote:
> Bongani wrote:
> > 
> > Hi
> > 
> > Does anyone what cause's these message. I have a 41M messages file
> > because of the.
> > 
> > Jul  1 04:02:14 localhost kernel: EXT3-fs error (device ide0(3,70)):
> > ext3_new_block: Allocating block in system zone - block = 32802
> 
> Your filesystem is wrecked.  Did you get some I/O errors?
 
I found these from the day before

Jun 30 12:31:00 localhost kernel: hdb: dma_intr: status=0x51 {DriveReady
SeekComplete Error }
Jun 30 12:31:00 localhost kernel: hdb: dma_intr: error=0x84
{DriveStatusError BadCRC }


> 
> You need to unmount it, run `e2fsck -f' and fix it up.
>

I have done that already

Thank you


