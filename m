Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129215AbQKFORr>; Mon, 6 Nov 2000 09:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129529AbQKFORh>; Mon, 6 Nov 2000 09:17:37 -0500
Received: from neuron.moberg.com ([209.152.208.195]:7174 "EHLO
	neuron.moberg.com") by vger.kernel.org with ESMTP
	id <S129378AbQKFOR1>; Mon, 6 Nov 2000 09:17:27 -0500
Date: Mon, 6 Nov 2000 09:17:17 -0500 (EST)
From: George Talbot <george@brain.moberg.com>
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
cc: linux-kernel@vger.kernel.org
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a 
 user-land
In-Reply-To: <200011040423.XAA21508@tsx-prime.MIT.EDU>
Message-ID: <Pine.LNX.4.21.0011060913510.4984-100000@brain.moberg.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You know, a more concise way of stating my underlying question might be:

	Does POSIX require that programs be aware of signals, in the
	"returning EINTR" sense, if they do not use signals, and only use
	pthreads?

I might want to write a program that uses pthreads instead of signals to
handle asynchronous program behavior so that said program might be
portable to a system that implements pthreads but not signals.

--
George T. Talbot
<george@moberg.com>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
