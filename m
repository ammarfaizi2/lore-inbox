Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265092AbSLQOb2>; Tue, 17 Dec 2002 09:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbSLQOb2>; Tue, 17 Dec 2002 09:31:28 -0500
Received: from med-gwia-02a.med.umich.edu ([141.214.93.150]:40982 "EHLO
	mail-02.med.umich.edu") by vger.kernel.org with ESMTP
	id <S265092AbSLQOb1>; Tue, 17 Dec 2002 09:31:27 -0500
Message-Id: <sdfef0cc.007@mail-02.med.umich.edu>
X-Mailer: Novell GroupWise Internet Agent 6.0.2
Date: Tue, 17 Dec 2002 09:39:04 -0500
From: "Nicholas Berry" <nikberry@med.umich.edu>
To: <root@chaos.analogic.com>, <sanju93csd@yahoo.co.in>
Cc: <Matt_Domsch@dell.com>, <linux-kernel@vger.kernel.org>
Subject: Re: How to get the size of the block device ???? (Important)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the question being asked is 'how do I find out how many block
long the device is?'

You can open it, seek to the end, then the file postiton will tell you
the size of the device.

Nik


>>> "Richard B. Johnson" <root@chaos.analogic.com> 12/17/02 09:36AM
>>>
On Tue, 17 Dec 2002, [iso-8859-1] Sanjay Kumar wrote:

> Hi,
>   I am Sanjay Kumar and wants to write my own file
> system on Linux. I have almost written the code.
>   But,now i have a problem while writing the code 
> for "mkfs" for my filesystem.
> 
> Problem Summary : I need the size of the block device
> in bytes on which my file system will be created.
> Actually, there is a feild in the super block, needs
> the total no of blocks on the device while while
> creating the filesystem. So, Can you Plz. help me out
> of this problem.
> 

You make an ioctl() function for your file-system that returns
the block-size that you selected when you designed the system.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about
it.

