Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273303AbRJDKPB>; Thu, 4 Oct 2001 06:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273302AbRJDKOv>; Thu, 4 Oct 2001 06:14:51 -0400
Received: from mail.spylog.com ([194.67.35.220]:18114 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S273303AbRJDKOt>;
	Thu, 4 Oct 2001 06:14:49 -0400
Date: Thu, 4 Oct 2001 14:15:13 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.4.11-pre2-xfs
Message-ID: <20011004141513.A5421@spylog.ru>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011004115236.A9373@ulysse.olympe.o2t>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20011004115236.A9373@ulysse.olympe.o2t>
User-Agent: Mutt/1.3.22i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

 1. hardware Intel ISP1100 (BX/1GB RAM/IDE DISK)
 2. kernel 2.4.11-pre2-xfs, with highmem support

 3. create ramdisk 512Mb and run "tiotest -c -f 110"
 4. 
 
 __alloc_pages: 0-order allocation failed (gfp=0x3d0/0) from c0127fe9
 __alloc_pages: 0-order allocation failed (gfp=0x2f0/0) from c0127fe9
 __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c0127fe9
 __alloc_pages: 0-order allocation failed (gfp=0x2f0/0) from c0127fe9
 __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c0127fe9
 __alloc_pages: 0-order allocation failed (gfp=0x2f0/0) from c0127fe9
 __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c0127fe9
 __alloc_pages: 0-order allocation failed (gfp=0x3f0/0) from c0127fe9
 __alloc_pages: 0-order allocation failed (gfp=0x3f0/0) from c0127fe9
 __alloc_pages: 0-order allocation failed (gfp=0x3f0/0) from c0127fe9
 __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c0127fe9
 __alloc_pages: 0-order allocation failed (gfp=0x2f0/0) from c0127fe9
 __alloc_pages: 0-order allocation failed (gfp=0x2f0/0) from c0127fe9
 __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c0127fe9
 
 5. kernel compiled with gdb & have serial console.

-- 
bye.
Andrey Nekrasov, SpyLOG.
