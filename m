Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271005AbRH3Iak>; Thu, 30 Aug 2001 04:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270333AbRH3Iab>; Thu, 30 Aug 2001 04:30:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33932 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270319AbRH3IaV>;
	Thu, 30 Aug 2001 04:30:21 -0400
Date: Thu, 30 Aug 2001 01:30:23 -0700 (PDT)
Message-Id: <20010830.013023.94071732.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: manik@cisco.com, linux-kernel@vger.kernel.org
Subject: Re: ioctl conflicts
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E15cN49-0000fz-00@the-village.bc.nu>
In-Reply-To: <3B8DEF9D.26F7544D@cisco.com>
	<E15cN49-0000fz-00@the-village.bc.nu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Thu, 30 Aug 2001 09:20:45 +0100 (BST)

   > I was grep-ing on a 2.4 source tree when i found the
   > following :
   > 
   > ./include/linux/videodev.h:#define VIDIOCGCAP          
   > _IOR('v',1,struct video_capability)
   > ./include/linux/ext2_fs.h:#define  EXT2_IOC_GETVERSION  _IOR('v',1,
   > long)   
   
   Thats fine. ext2 ioctls and video ioctls go to different places

Consider sparc64.

Later,
David S. Miller
davem@redhat.com
