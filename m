Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143781AbRAHNi1>; Mon, 8 Jan 2001 08:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143734AbRAHNiR>; Mon, 8 Jan 2001 08:38:17 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:10650 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S143721AbRAHNiE>; Mon, 8 Jan 2001 08:38:04 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Adam J. Richter" <adam@yggdrasil.com>, parsley@roanoke.edu,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Patch (repost): cramfs memory corruption fix
In-Reply-To: <Pine.LNX.4.10.10101071153470.27944-100000@penguin.transmeta.com>
From: Christoph Rohland <cr@sap.com>
Date: 08 Jan 2001 14:37:13 +0100
In-Reply-To: Linus Torvalds's message of "Sun, 7 Jan 2001 11:56:38 -0800 (PST)"
Message-ID: <qwwwvc6tbau.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sun, 7 Jan 2001, Linus Torvalds wrote:
> I wonder what to do about this - the limits are obviously useful, as
> would the "use swap-space as a backing store" thing be. At the same
> time I'd really hate to lose the lean-mean-clean ramfs.

Let me repeat on this issue: shmem.c has everything needed for this
despite read and write and they should be really easy to add. 

I did not plan to write them in the near future because I did not
think that this is a really wanted feature. But I can look into it.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
