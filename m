Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268628AbRHBDoK>; Wed, 1 Aug 2001 23:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268636AbRHBDnu>; Wed, 1 Aug 2001 23:43:50 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:49165 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268628AbRHBDnr> convert rfc822-to-8bit; Wed, 1 Aug 2001 23:43:47 -0400
X-Apparently-From: <kiwiunixman@yahoo.co.nz>
From: Matthew Gardiner <kiwiunixman@yahoo.co.nz>
Date: Thu, 02 Aug 2001 03:43:54 GMT
Message-ID: <20010802.3435400@kiwiunixman.ihug.co.nz>
Subject: Re: SMP kernel oops
To: Usman Wahid <mswahid@yahoo.com>
CC: linux-kernel@vger.kernel.org
In-Reply-To: <20010802024918.20150.qmail@web11002.mail.yahoo.com>
In-Reply-To: <20010802024918.20150.qmail@web11002.mail.yahoo.com>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2; Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>>>>>>>>>>>>>>>>>> Original Message <<<<<<<<<<<<<<<<<<

On 8/2/01, 2:49:18 PM, Usman Wahid <mswahid@yahoo.com> wrote regarding SMP 
kernel oops:


> Hi,
> two of our smp linux web servers (2.2.12smp) were
> running fine for about a year until a month back. now
> they crash randomly from a week to a couple of days
> giving wait_on_bh oops. that can happen during both
> busy and not so busy times. following is the message
> we receive,
> wait_on_bh, CPU 0:
> irq: 0 [0 0]
> bh: 1 [0 1]
> <[c010a385] [c016881e] [c0162e6b] [c0163108]
> [c016f91e] [c01533cb]
> [c01537c5] [c012611d]

> and the mapping
> c010a385: synchronize_bh
> c016881e: tcp_v4_unhash
> c0162e6b: tcp_close_state
> c0163108: tcp_close
> c016f91e: inet_release
> c01533cb: sock_release
> c01537c5: sock_close
> c012611d: __fput

> appreciate any help,

> regards,
> saans

You may actually want upgrade that kernel, as most likely this error has 
already been addressed by later kernel releases.

Matthew Gardiner

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

