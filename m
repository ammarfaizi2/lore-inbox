Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275097AbRJJKrL>; Wed, 10 Oct 2001 06:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275288AbRJJKrC>; Wed, 10 Oct 2001 06:47:02 -0400
Received: from fe040.worldonline.dk ([212.54.64.205]:43026 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S275097AbRJJKqo>; Wed, 10 Oct 2001 06:46:44 -0400
Date: Wed, 10 Oct 2001 12:47:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@redhat.com>
Subject: [patch] block highmem zero bounce #16
Message-ID: <20011010124703.E3254@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've uploaded a new version. Pretty much just a kernel update:

- Merge 2.4.11 (me)
- Fix some pci64 patch deviates (me)
- Fix sym53c8xx compile error (Marcus Alanen, others)
- Don't hold io_request_lock on IDE b_end_io callback (me)

Get it here:

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.11/

There's a big version that includes the pci64 patch, and a block-only
(mostly :-) version that requires the pci64 patch.

-- 
Jens Axboe

