Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130202AbRA3Nfr>; Tue, 30 Jan 2001 08:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130908AbRA3Nf2>; Tue, 30 Jan 2001 08:35:28 -0500
Received: from chiara.elte.hu ([157.181.150.200]:11269 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130202AbRA3NfW>;
	Tue, 30 Jan 2001 08:35:22 -0500
Date: Tue, 30 Jan 2001 14:34:44 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Quim K Holland <qkholland@my-deja.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Desk check of raid5.c patch from mtew@cds.duke.edu?
In-Reply-To: <200101300234.SAA20191@mail4.bigmailbox.com>
Message-ID: <Pine.LNX.4.30.0101301433550.3726-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Jan 2001, Quim K Holland wrote:

> I've been following the recent 2.4.1-pre series and am wondering why
> the following one-liner (obviously correct) patch has not been
> applied. [...]

> -               return_ok = bh->b_reqnext;
> +               return_fail = bh->b_reqnext;

oops - i do have it in my tree, somehow it escaped.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
