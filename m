Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132826AbRARWVf>; Thu, 18 Jan 2001 17:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132807AbRARWVZ>; Thu, 18 Jan 2001 17:21:25 -0500
Received: from chiara.elte.hu ([157.181.150.200]:7940 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131582AbRARWVO>;
	Thu, 18 Jan 2001 17:21:14 -0500
Date: Thu, 18 Jan 2001 23:20:47 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Rick Jones <raj@cup.hp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <20010118231651.L28276@athlon.random>
Message-ID: <Pine.LNX.4.30.0101182319280.3437-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Jan 2001, Andrea Arcangeli wrote:

> BTW, the simmetry between getsockopt/setsockopt further bias how
> SIOCPUSH doesn't fit into the setsockopt options but it fits very well
> into the ioctl categorty instead. There's simply no state one can
> return via getsockopt for the SIOCPUSH functionality. It's not setting
> any option, it's just doing one thing that controls the I/O.

you convinced me. I guess i was just distracted by the common wisdom:
'ioctls are a hack'. But SIOCPUSH *IS* an 'IO control' after all :-)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
