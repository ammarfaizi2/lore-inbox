Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271927AbRHVErU>; Wed, 22 Aug 2001 00:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271928AbRHVErJ>; Wed, 22 Aug 2001 00:47:09 -0400
Received: from c252.h203149202.is.net.tw ([203.149.202.252]:43725 "EHLO
	mail.tahsda.org.tw") by vger.kernel.org with ESMTP
	id <S271927AbRHVErC>; Wed, 22 Aug 2001 00:47:02 -0400
Date: Wed, 22 Aug 2001 12:47:02 +0800
From: Tommy Wu <tommy@teatime.com.tw>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Memory Problem in 2.4.9 ?
Cc: Daniel Phillips <phillips@bonn-fries.net>
Reply-To: tommy@teatime.com.tw
Organization: TeaTime Development
Message-Id: <20010822124255.4DEE.TOMMY@teatime.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.07
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

   I've tried the patch in the kernel list. Got the result as following...
   This message for command: 
   dd if=/dev/zero of=test.dmp bs=1000k count=2500
   on a PIII 1G SMP box with 1G RAM (HIGHMEM enabled)
   kernel 2.4.9 with XFS filesystem patch.
   
Aug 22 11:51:04 standby kernel: __alloc_pages: 0-order allocation failed (gfp=0x30/1).
Aug 22 11:51:11 standby last message repeated 111 times
Aug 22 11:51:11 standby kernel: cation failed (gfp=0x30/1).
Aug 22 11:51:11 standby kernel: __alloc_pages: 0-order allocation failed (gfp=0x30/1).
Aug 22 11:51:11 standby last message repeated 281 times
Aug 22 11:51:17 standby kernel: cation failed (gfp=0x30/1).
Aug 22 11:51:17 standby kernel: __alloc_pages: 0-order allocation failed (gfp=0x30/1).
Aug 22 11:51:29 standby last message repeated 315 times
Aug 22 11:51:29 standby kernel: cation failed (gfp=0x30/1).
Aug 22 11:51:29 standby kernel: __alloc_pages: 0-order allocation failed (gfp=0x30/1).
Aug 22 11:51:29 standby last message repeated 281 times
Aug 22 11:52:21 standby last message repeated 43 times
Aug 22 11:52:21 standby kernel: cation failed (gfp=0x30/1).
Aug 22 11:52:21 standby kernel: __alloc_pages: 0-order allocation failed (gfp=0x30/1).
Aug 22 11:52:22 standby last message repeated 290 times


-- 

    Tommy Wu
    mailto:tommy@teatime.com.tw
    http://www.teatime.com.tw/~tommy
    ICQ: 22766091
    Mobile Phone: +886 936 909490
    TeaTime BBS +886 2 31515964 24Hrs V.Everything


