Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266478AbSLJAdf>; Mon, 9 Dec 2002 19:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266487AbSLJAdf>; Mon, 9 Dec 2002 19:33:35 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:4488 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S266478AbSLJAde> convert rfc822-to-8bit; Mon, 9 Dec 2002 19:33:34 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Matt Young <wz6b@arrl.net>
Reply-To: wz6b@arrl.net
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: grub and 2.5.50
Date: Mon, 9 Dec 2002 16:40:35 -0800
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212091640.35716.wz6b@arrl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These grub commands work with SUSE 2.4.19-4GB:

   kernel (hd0,0)/bzImage root=/dev/hda3   vga=791
   initrd (hd0,0)/initrd

But with 2.5.50 the kernel panics after Freeing the initrd memory with 
"Unable te mount root FS, please correct the root= cammand line"

I have compiled with the required file systems (EXT2,EXT3,REISERFS).
