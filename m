Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318030AbSG2FqQ>; Mon, 29 Jul 2002 01:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318031AbSG2FqQ>; Mon, 29 Jul 2002 01:46:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51719 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318030AbSG2FqQ>; Mon, 29 Jul 2002 01:46:16 -0400
Date: Sun, 28 Jul 2002 22:50:14 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: martin@dalecki.de, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
In-Reply-To: <20020729073943.A4445@suse.de>
Message-ID: <Pine.LNX.4.44.0207282248050.3768-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Jul 2002, Jens Axboe wrote:
>
> I was referring to the block layer, not the SCSI layer. The broken
> changes were applied to the block layer after all, I had not even
> noticed that the SCSI one was broken.

Heh.

Anyway, I don't think the situation is "wrong" per se. Martin took code
that was generic from SCSI, and moved it to the common place. In the
process, you noticed that the original code was broken. Downsides? I guess
it gets fixed now. Sounds reasonable to me, and we should just be happy
that these things get noticed eventually, even if the reason for noticing
it is the "wrong" one.

			Linus

