Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288851AbSANSyO>; Mon, 14 Jan 2002 13:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288859AbSANSx0>; Mon, 14 Jan 2002 13:53:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22288 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288809AbSANSwj>; Mon, 14 Jan 2002 13:52:39 -0500
Date: Mon, 14 Jan 2002 10:50:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@caldera.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-lvm@sistina.com>,
        Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-lvm] Re: [RFLART] kdev_t in ioctls
In-Reply-To: <20020114194554.A5885@caldera.de>
Message-ID: <Pine.LNX.4.33.0201141048050.1161-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Jan 2002, Christoph Hellwig wrote:
>
> I know - still it makes Linus' suggestion not work on ~90% of the
> systems.

It doesn't matter if user-land compilation breaks. As long as old binaries
work (and they will), we're fine.

User-land was _already_ broken. By virtue of using a type that it should
NOT have used.

If you want to use __kernel_dev_t, go ahead.

		Linus

