Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269274AbRH3Hsm>; Thu, 30 Aug 2001 03:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270031AbRH3Hsc>; Thu, 30 Aug 2001 03:48:32 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:24299 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S269274AbRH3HsO>; Thu, 30 Aug 2001 03:48:14 -0400
Message-ID: <3B8DEF9D.26F7544D@cisco.com>
Date: Thu, 30 Aug 2001 13:17:41 +0530
From: Manik Raina <manik@cisco.com>
Organization: Cisco Systems
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: manik@cisco.com
Subject: ioctl conflicts
In-Reply-To: <20010828145304Z.haba@pdc.kth.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was grep-ing on a 2.4 source tree when i found the
following :

./include/linux/videodev.h:#define VIDIOCGCAP          
_IOR('v',1,struct video_capability)
./include/linux/ext2_fs.h:#define  EXT2_IOC_GETVERSION  _IOR('v',1,
long)   

Aren't these supposed to be conflicts ?

-Manik
