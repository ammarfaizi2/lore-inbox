Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131224AbRCUGnh>; Wed, 21 Mar 2001 01:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131232AbRCUGn1>; Wed, 21 Mar 2001 01:43:27 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:47902 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S131224AbRCUGnM>; Wed, 21 Mar 2001 01:43:12 -0500
Date: Wed, 21 Mar 2001 08:42:21 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: hingwah@programmer.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hang when using loop device
Message-ID: <20010321084220.H5316@niksula.cs.hut.fi>
In-Reply-To: <20010321121605.A822@hingwah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010321121605.A822@hingwah>; from hingwah@programmer.net on Wed, Mar 21, 2001 at 12:16:05PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2001 at 12:16:05PM +0800, you [hingwah@programmer.net] claimed:
> Hello all,
> 
> 	Recently my ext2 partition out of space so I have made a regular file
> in the FAT32 partition and format it  as ext2 partiton and mount it as 
> loop device.However,occasionaly when I extract a large tar to the loop device..
> The computer will hang while extracting. I wonder if deadlock occur.
> I'm using kernel 2.4.1 now and there is no problem when I am using
> kernel 2.2.x kernel

Jens Axboe fixed this. The fix is merged in 2.4.2ac20 and 2.4.3pre6. The fix
will be in 2.4.3. Please search the mailing list archive before asking...


-- v --

v@iki.fi
