Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131039AbRAPEvt>; Mon, 15 Jan 2001 23:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131045AbRAPEvj>; Mon, 15 Jan 2001 23:51:39 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:62732 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S131039AbRAPEv2>; Mon, 15 Jan 2001 23:51:28 -0500
Date: Mon, 15 Jan 2001 20:51:26 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Jonathan Thackray <jthackray@zeus.com>
Subject: Re: [patch] sendpath() support, 2.4.0-test3/-ac9
In-Reply-To: <Pine.LNX.4.30.0101152141320.6418-300000@elte.hu>
Message-ID: <Pine.LNX.4.30.0101152049580.14995-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.30.0101152143111.6418@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2001, Ingo Molnar wrote:

> just for kicks i've implemented sendpath() support.
>
> _syscall4 (int, sendpath, int, out_fd, char *, path, off_t *, off, size_t, size)

hey so how do you implement transmit timeouts with sendpath() ?  (i.e.
drop the client after 30 seconds of no progress.)

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
