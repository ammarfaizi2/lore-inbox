Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283574AbRK3JIO>; Fri, 30 Nov 2001 04:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283572AbRK3JIE>; Fri, 30 Nov 2001 04:08:04 -0500
Received: from gateway-2.hyperlink.com ([213.52.152.2]:51217 "EHLO
	core-gateway-1.hyperlink.com") by vger.kernel.org with ESMTP
	id <S283574AbRK3JHx>; Fri, 30 Nov 2001 04:07:53 -0500
Message-ID: <4548.10.119.8.1.1007111319.squirrel@extranet.jtrix.com>
Date: Fri, 30 Nov 2001 09:08:39 -0000 (GMT)
Subject: Re: 2.5.1-pre4 compile error - pd.c
From: "Martin A. Brooks" <martin@jtrix.com>
To: <axboe@suse.de>
In-Reply-To: <20011130100153.S16796@suse.de>
In-Reply-To: <20011130100153.S16796@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.0 [rc2])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> max_sectors has been moved into the queue. So when you did this before
>
> max_sectors[dev indexing] = max_sectors_in_request
>
> you now do
>
> q = blk_get_queue(dev);
> blk_queue_max_sectors(max_sectors_in_request);

I'm sure you're right, but I'm no kernel hacker.  Just a chimp with a
compiler :)

--
Martin A. Brooks   Systems Administrator
Jtrix Ltd          t: +44 7395 4990
57-59 Neal Street  f: +44 7395 4991
London, WC2H 9PP   e: martin@jtrix.com


