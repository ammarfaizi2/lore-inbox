Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268867AbRHBJrg>; Thu, 2 Aug 2001 05:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268870AbRHBJr0>; Thu, 2 Aug 2001 05:47:26 -0400
Received: from web20010.mail.yahoo.com ([216.136.225.73]:27143 "HELO
	web20010.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268867AbRHBJrP>; Thu, 2 Aug 2001 05:47:15 -0400
Message-ID: <20010802094719.43751.qmail@web20010.mail.yahoo.com>
Date: Thu, 2 Aug 2001 17:47:19 +0800 (CST)
From: =?gb2312?q?=D0=C2=20=D4=C2?= <xinyuepeng@yahoo.com>
Subject: About the cramfs
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!
         I was creating the cramfs image using
/linux/scripts/mkcramfs.c,because of the big endian,so
I got 
a patch to convert. 
        When I mounted the cramfs as root
filesystem,it worked, and to read directory was also
ok,but When 
I tried to read the files ,I found that it didn't work
well.Sometimes,error emerged as follow:
           bash>Error -3 while decompressing!
             00158fb8(67829187)->001f0000(1024) 
and I used system page size is 1024,when the file size
was beyond page size,the error must emerge.
       I think it is possible that I used the zlib
which is used in kernel 3.x ,but the kernel  I used is
2.x,but I didn't sure.
       Could you explain it? Thanks
  
Best Regards:
                     ypxin



