Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130202AbRCHXGu>; Thu, 8 Mar 2001 18:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130209AbRCHXGa>; Thu, 8 Mar 2001 18:06:30 -0500
Received: from glatton.cnchost.com ([207.155.248.47]:2021 "EHLO
	glatton.cnchost.com") by vger.kernel.org with ESMTP
	id <S130202AbRCHXGX>; Thu, 8 Mar 2001 18:06:23 -0500
Message-ID: <3AA810DF.3070809@devries.tv>
Date: Thu, 08 Mar 2001 18:08:15 -0500
From: Peter DeVries <peter@devries.tv>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Progress with drive corruption with KT7-RAID.  
Content-Type: multipart/mixed;
 boundary="------------070104070404000705030708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070104070404000705030708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

  When I put the HD on ide2 and do the appropriate changes (ide=reverse) 
The systemn is more stable.  I am getting the following message when 
moving data around.  There seems to be a little corruption of the 
directory stucture, Specifically in /usr/src/linux which I just used to 
compile the kernel.



--------------070104070404000705030708
Content-Type: text/plain;
 name="error-dma-2.4.2-ac12"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="error-dma-2.4.2-ac12"

Config - 2.4.2-ac12, 20g IBM drive UDMA33, HD on Highpoint controller,
UDMA100, ide2

EXT2-fs error (device ide0(3,10)): ext2_readdir: bad entry in directory #32447:
rec_len is smaller than minimal - offset=0, inode=0, rec_len=0, name_len=0
cp: /usr/src/linux/ipc/util.c: Input/output error
cp: /usr/src/linux/ipc/Makefile: Input/output error
cp: /usr/src/linux/ipc/util.h: Input/output error
cp: /usr/src/linux/drivers: Input/output error


--------------070104070404000705030708--

