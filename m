Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273737AbRIXCDq>; Sun, 23 Sep 2001 22:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273738AbRIXCDg>; Sun, 23 Sep 2001 22:03:36 -0400
Received: from pa147.antoniuk.sdi.tpnet.pl ([213.25.59.147]:8832 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S273737AbRIXCDa>; Sun, 23 Sep 2001 22:03:30 -0400
Date: Mon, 24 Sep 2001 04:02:08 +0200
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jpopl@interia.pl>
To: linux-kernel@vger.kernel.org
Subject: __alloc_pages: 0-order allocation failed
Message-ID: <20010924040208.A624@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just installed 2.4.10, and...

__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
VM: killing process donkey_s
__alloc_pages: 0-order allocation failed (gfp=0x1f0/0) from c0126c2e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
VM: killing process screen
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
VM: killing process bash
(...)

I am changing kernels often, but never seen that kind of message. Last kernel I
had before 2.4.10 was 2.4.10-pre4.

PS. donkey_s is application which eats a lot of memory, but I have 384MB RAM
and 100MB swap.
