Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131233AbRCUHZC>; Wed, 21 Mar 2001 02:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131236AbRCUHYw>; Wed, 21 Mar 2001 02:24:52 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:30592 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S131233AbRCUHYl>;
	Wed, 21 Mar 2001 02:24:41 -0500
Message-ID: <3AB85706.44AC2982@mirai.cx>
Date: Tue, 20 Mar 2001 23:23:50 -0800
From: J Sloan <jjs@mirai.cx>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: agrawal@ais.org, hingwah@programmer.net
Subject: Re: Hang when using loop device
In-Reply-To: <Pine.LNX.4.10.10103210132420.4004-100000@SLASH.REM.CMU.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

agrawal@ais.org wrote:

> > Hello all,
> >
> >       Recently my ext2 partition out of space so I have made a regular file
> > in the FAT32 partition and format it  as ext2 partiton and mount it as
> > loop device.However,occasionaly when I extract a large tar to the loop device..
> > The computer will hang while extracting. I wonder if deadlock occur.
> > I'm using kernel 2.4.1 now and there is no problem when I am using
> > kernel 2.2.x kernel
>
> There are known problems with some of the 2.4 series kernels and loopback
> device support. Look through the kernel archives for Jens Axboe's patches,
> or grab one of the latest ac (Alan Cox) kernels.

The fix is also in the 2.4.3-pre series -

cu

Jup

