Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279644AbRKIHak>; Fri, 9 Nov 2001 02:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279631AbRKIHaa>; Fri, 9 Nov 2001 02:30:30 -0500
Received: from posta2.elte.hu ([157.181.151.9]:2796 "HELO posta2.elte.hu")
	by vger.kernel.org with SMTP id <S279627AbRKIHaX>;
	Fri, 9 Nov 2001 02:30:23 -0500
Date: Fri, 9 Nov 2001 09:28:09 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
In-Reply-To: <20011108153749.A14468@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.33.0111090924400.2240-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Nov 2001, Mike Fedyk wrote:

> It remains to be proven whether the coarser scheduling approach
> (Ingo's) will actually help when looking at cache properties.... [...]

have you seen the numbers/measurements i posted in my original email? 3%
kernel compile speedup on an 'idle' 8-way system, 7% compilation speedup
with HZ=1024 and background networking load on a 1-way system.

	Ingo

