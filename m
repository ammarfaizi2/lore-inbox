Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbSKERXs>; Tue, 5 Nov 2002 12:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbSKERXh>; Tue, 5 Nov 2002 12:23:37 -0500
Received: from air-2.osdl.org ([65.172.181.6]:25773 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265014AbSKERVe>;
	Tue, 5 Nov 2002 12:21:34 -0500
Date: Tue, 5 Nov 2002 09:23:42 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Jens Axboe <axboe@suse.de>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 vi .config ; make oldconfig not working
In-Reply-To: <20021105171409.GA1137@suse.de>
Message-ID: <Pine.LNX.4.33L2.0211050922390.21048-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2002, Jens Axboe wrote:

| > make oldconfig" kernel configurator :)
|
| Hmmm:
|
| axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
| 641:CONFIG_NFSD_V4=y
| axboe@burns:[.]linux-2.5-deadline-rbtree $ vi .config
| axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
| 641:CONFIG_NFSD_V4=n
| axboe@burns:[.]linux-2.5-deadline-rbtree $ make oldconfig
| axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
| 641:CONFIG_NFSD_V4=y

Yes, I saw this behavior last night also (on different options).

-- 
~Randy

