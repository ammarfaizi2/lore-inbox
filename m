Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129953AbRASKTa>; Fri, 19 Jan 2001 05:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131118AbRASKTU>; Fri, 19 Jan 2001 05:19:20 -0500
Received: from Cantor.suse.de ([194.112.123.193]:2832 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129953AbRASKTH>;
	Fri, 19 Jan 2001 05:19:07 -0500
To: Padraig Brady <Padraig@AnteFacto.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Documenting stat(2)
In-Reply-To: <20010118020528.A16871@jhereg.dmeyer.net>
	<3A66D93C.8090500@AnteFacto.com>
X-Yow: I wonder if I should put myself in ESCROW!!
From: Andreas Schwab <schwab@suse.de>
Date: 19 Jan 2001 11:18:56 +0100
In-Reply-To: <3A66D93C.8090500@AnteFacto.com>
Message-ID: <jer91zsv3j.fsf@hawking.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.96
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Padraig Brady <Padraig@AnteFacto.com> writes:

|> dmeyer@dmeyer.net wrote:
|> 
|> > In article <9463fj$gsq$1@penguin.transmeta.com> you write:
|> >
|> >> Basically, the _only_ think you should depend on is that st_size
|> >> contains:
|> >>  - for regular files, the size of the file in bytes
|> >>  - for symlinks, the length of the symlink.
|> > I don't think this is right - for a symlink, stat should return the
|> > size of the file; lstat should return the size of the symlink.
|> 
|> Nope stat should return the details of the symlink
|> whereas lstat should return the details of the symlink target.

Nope, check the facts.

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
