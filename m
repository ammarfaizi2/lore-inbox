Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130764AbRBDNs5>; Sun, 4 Feb 2001 08:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131453AbRBDNsr>; Sun, 4 Feb 2001 08:48:47 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:25861 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130764AbRBDNsj>; Sun, 4 Feb 2001 08:48:39 -0500
Date: Sun, 4 Feb 2001 13:48:33 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Christoph Rohland <cr@sap.com>
cc: Mike Galbraith <mikeg@wen-online.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch?] RAMFS
In-Reply-To: <m3r91en5jj.fsf@linux.local>
Message-ID: <Pine.LNX.4.30.0102041342260.17227-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Feb 2001, Christoph Rohland wrote:

> Yes and no. tmpfs has a little bit overhead for the noswap case but
> this overhead is in the kernel anyways for shared anon mappings. The
> whole vm is using swap unconditionally.

I'm hoping that'll end up conditional on CONFIG_BLK_DEV or CONFIG_SWAP. 

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
