Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276468AbRKFA5q>; Mon, 5 Nov 2001 19:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276477AbRKFA5g>; Mon, 5 Nov 2001 19:57:36 -0500
Received: from mail.fluke.com ([129.196.128.53]:50956 "EHLO
	evtvir03.tc.fluke.com") by vger.kernel.org with ESMTP
	id <S276468AbRKFA5U>; Mon, 5 Nov 2001 19:57:20 -0500
Date: Mon, 5 Nov 2001 16:57:18 -0800 (PST)
From: David Dyck <dcd@tc.fluke.com>
To: <linux-kernel@vger.kernel.org>
cc: Jens Axboe <axboe@suse.de>
Subject: 2.4.14 doesn't compile: deactivate_page not defined in loop.c
Message-ID: <Pine.LNX.4.33.0111051654140.4708-100000@dd.tc.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0x8ad9): undefined reference to `deactivate_page'
drivers/block/block.o(.text+0x8b19): undefined reference to `deactivate_page'


a grep from deactivate_page only shows up in  linux/drivers/block/loop.c



