Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276930AbRJCJFv>; Wed, 3 Oct 2001 05:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276928AbRJCJFa>; Wed, 3 Oct 2001 05:05:30 -0400
Received: from unnamed.deltanet.ro ([193.226.175.58]:35332 "HELO
	kamov.deltanet.ro") by vger.kernel.org with SMTP id <S276929AbRJCJF1>;
	Wed, 3 Oct 2001 05:05:27 -0400
Date: Wed, 03 Oct 2001 12:05:35 +0300
From: Petru Paler <ppetru@ppetru.net>
To: Pierre PEIFFER <pierre.peiffer@sxb.bsf.alcatel.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: e2compress in kernel 2.4
Message-ID: <46620000.1002099935@shiva>
In-Reply-To: <3BBACF29.7BB980C4@sxb.bsf.alcatel.fr>
In-Reply-To: <3BBACF29.7BB980C4@sxb.bsf.alcatel.fr>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-AntiVirus: DeltaNET> Mesaj verificat cu / Message scanned with: AntiVir/Linux Version 6.7.0.1, (Apr 22 2001, 19:14:45)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, October 03, 2001 10:41:14 +0200 Pierre PEIFFER 
<pierre.peiffer@sxb.bsf.alcatel.fr> wrote:

>     So, here, we are a little bit confused because we don't know where
> to introduce the compression, if we keep the same idea of the 2.2
> design... In fact, on one hand, once the buffers will be compressed, the
> pages will also become compressed, but on the other hand, we don't want
> the pages to be compressed, because, the pages, once registered and
> linked to the inode are supposed to be uncompressed...

Why don't you build it on top of ext3, and do compression right before a 
transaction commit?

--
Real programmers use chmod +x /dev/random and cross their fingers.

