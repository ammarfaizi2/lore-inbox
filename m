Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRAIKtL>; Tue, 9 Jan 2001 05:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129749AbRAIKtH>; Tue, 9 Jan 2001 05:49:07 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:10719 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S129413AbRAIKs4>;
	Tue, 9 Jan 2001 05:48:56 -0500
Date: Tue, 9 Jan 2001 11:48:53 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: Stefan Traby <stefan@hello-penguin.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: `rmdir .` doesn't work in 2.4
In-Reply-To: <20010109090936.A2900@stefan.sime.com>
Message-ID: <Pine.LNX.4.31.0101091146330.4632-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Stefan Traby wrote:
> "rmdir `pwd`" is required to fail (at least under csh, bash, ksh) if the
> path component contains a white space and thereof it can't be a valid
> replacement for Andreas "rmdir ." which was what Al initially suggested.
>
> Yes, I'm very pickey about that; but hey, I don't want to force anyone
> to write GNU/Linux like rms; just valid shell code. :)

Of course you should do rmdir "`pwd`"
But this is a userspace issue.

Eric

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
