Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316885AbSFARd2>; Sat, 1 Jun 2002 13:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316979AbSFARd1>; Sat, 1 Jun 2002 13:33:27 -0400
Received: from mail.ah.edu.cn ([210.45.224.8]:42630 "HELO mail.ah.edu.cn")
	by vger.kernel.org with SMTP id <S316885AbSFARd0>;
	Sat, 1 Jun 2002 13:33:26 -0400
Mailbox-Line: From chyang@ah.edu.cn Sun Jun 02 01:32:23 2002
Message-Id: <20020602.AAA1022952482@ah.edu.cn>
From: "Chen Yang" <chyang@ah.edu.cn>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Does VM of 2.4.18 have bugs?
Date: Sun, 2 Jun 2002 01:32:23 +0800
MIME-Version: 1.0
X-Priority: 1
X-Mailer: @MESSAGE-5.0.0905.1.2400 (Linux 2.4.18-6mdk)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  We installed a Mandrake 8.2 with the kernel of 
2.4.18 . We are using rsync to backup the data.
After some time, dmesg will print:

__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
__alloc_pages: 0-order allocation failed (gfp=0xf0/0)
__alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
VM: killing process klogd
__alloc_pages: 0-order allocation failed (gfp=0xf0/0)
__alloc_pages: 0-order allocation failed (gfp=0xf0/0)
__alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
__alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
__alloc_pages: 0-order allocation failed (gfp=0xf0/0)
__alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
__alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
__alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
VM: killing process rsync
__alloc_pages: 0-order allocation failed (gfp=0xf0/0)
__alloc_pages: 0-order allocation failed (gfp=0xf0/0)
__alloc_pages: 0-order allocation failed (gfp=0xf0/0)
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
VM: killing process rsync
__alloc_pages: 0-order allocation failed (gfp=0xf0/0)
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)

This must be caused by the giant datas and memory leaks
in Virtual memory management.Does anyone know some solutions?
Thanks.

---
  Chen Yang
  http://mail.ustc.edu.cn/~chyang/








