Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270121AbRH3IRk>; Thu, 30 Aug 2001 04:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270314AbRH3IRU>; Thu, 30 Aug 2001 04:17:20 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19470 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270121AbRH3IRK>; Thu, 30 Aug 2001 04:17:10 -0400
Subject: Re: ioctl conflicts
To: manik@cisco.com (Manik Raina)
Date: Thu, 30 Aug 2001 09:20:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, manik@cisco.com
In-Reply-To: <3B8DEF9D.26F7544D@cisco.com> from "Manik Raina" at Aug 30, 2001 01:17:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cN49-0000fz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was grep-ing on a 2.4 source tree when i found the
> following :
> 
> ./include/linux/videodev.h:#define VIDIOCGCAP          
> _IOR('v',1,struct video_capability)
> ./include/linux/ext2_fs.h:#define  EXT2_IOC_GETVERSION  _IOR('v',1,
> long)   

Thats fine. ext2 ioctls and video ioctls go to different places
