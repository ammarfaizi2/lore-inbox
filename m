Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131784AbQKJWrg>; Fri, 10 Nov 2000 17:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131894AbQKJWr1>; Fri, 10 Nov 2000 17:47:27 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:45127 "EHLO
	amsmta02-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S131784AbQKJWrQ>; Fri, 10 Nov 2000 17:47:16 -0500
Date: Sat, 11 Nov 2000 00:55:04 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: willy tarreau <wtarreau@yahoo.fr>
cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in
 /var/spool/mqueue]
In-Reply-To: <20001110202221.29946.qmail@web1106.mail.yahoo.com>
Message-ID: <Pine.LNX.4.21.0011110053250.6465-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, [iso-8859-1] willy tarreau wrote:

> Dick, have you tried a simple "strace -f -p <pid>" ?
> This often gives enough info.
> 
> BTW, there's one version of sendmail that tests the
> capability security hole of a previous kernel version
> (2.2.15 ?), and refuses to launch if it discovers it.
> It may be possible that sendmail does other tests like
> this one.

All recent version of sendmail check the kernel if it has the famous 'I
don't drop my root privs entirely' bug. This bug isn't the issue, sendmail
complains loudly when it finds a kernel with that bug, and won't even
start.

I'm testing with a 50 MB file now.. See how it goes :)

> Regards,
> Willy


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
