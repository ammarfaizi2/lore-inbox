Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131206AbRCUGag>; Wed, 21 Mar 2001 01:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131207AbRCUGa0>; Wed, 21 Mar 2001 01:30:26 -0500
Received: from SLASH.REM.CMU.EDU ([128.2.87.44]:14598 "EHLO SLASH.REM.CMU.EDU")
	by vger.kernel.org with ESMTP id <S131206AbRCUGaN>;
	Wed, 21 Mar 2001 01:30:13 -0500
From: agrawal@ais.org
Date: Wed, 21 Mar 2001 01:33:39 -0500 (EST)
To: hingwah@programmer.net
cc: linux-kernel@vger.kernel.org
Subject: Re: Hang when using loop device
In-Reply-To: <20010321121605.A822@hingwah>
Message-ID: <Pine.LNX.4.10.10103210132420.4004-100000@SLASH.REM.CMU.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hello all,
> 
> 	Recently my ext2 partition out of space so I have made a regular file
> in the FAT32 partition and format it  as ext2 partiton and mount it as 
> loop device.However,occasionaly when I extract a large tar to the loop device..
> The computer will hang while extracting. I wonder if deadlock occur.
> I'm using kernel 2.4.1 now and there is no problem when I am using
> kernel 2.2.x kernel

There are known problems with some of the 2.4 series kernels and loopback
device support. Look through the kernel archives for Jens Axboe's patches,
or grab one of the latest ac (Alan Cox) kernels.


