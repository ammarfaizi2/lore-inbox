Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143632AbRAHPhF>; Mon, 8 Jan 2001 10:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143796AbRAHPg4>; Mon, 8 Jan 2001 10:36:56 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:29969 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S143632AbRAHPgr>; Mon, 8 Jan 2001 10:36:47 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: David Weinehall <tao@acc.umu.se>
cc: Nick Holloway <Nick.Holloway@pyrites.org.uk>, linux-kernel@vger.kernel.org
Message-ID: <862569CE.0055ADCC.00@smtpnotes.altec.com>
Date: Mon, 8 Jan 2001 09:36:33 -0600
Subject: Re: Change of policy for future 2.2 driver submissions
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Cool!  I remember reading about the --dry-run option in the patch man page once,
and thinking it would be useful, but then I forgot all about it without ever
using it.  (Patch is one of those programs I've been using for so many years
that my fingers type it automatically and I never think to check out other
options.)  Thanks for reminding me.

I always rename my directories to the current patchlevel, too.  But in this case
it didn't help me, because I wasn't sure whether the prerelease-to-final was
supposed to be applied to 2.4.0-prerelease INSTEAD OF prerelease-diff or IN
ADDITION to it.  (After all, -test1 through test-12 all had to be applied in
order, but the various -testX-pre1, -pre2, etc. patches we've seen always had to
be reversed before the next one could be applied.)  Rather than take the time to
investigate, I took a guess, and obviously guessed wrong about this one.  :-)

Wayne




David Weinehall <tao@acc.umu.se> on 01/08/2001 05:07:08 AM

To:   Wayne Brown/Corporate/Altec@Altec
cc:   Nick Holloway <Nick.Holloway@pyrites.org.uk>, linux-kernel@vger.kernel.org

Subject:  Re: Change of policy for future 2.2 driver submissions



You know, there are reasons why patch has an option called --dry-run...

bzcat patch-2.4.0.bz2 | patch -p1 --dry-run
[and if everything goes well]
bzcat patch-2.4.0.bz2 | patch -p1
[will be relatively painless, as the files will be cached by now...]

Is the way I usually apply patches.

Oh, and after applying a patch I always rename the directory to match
the version of the patch. This way I always know if I have to unapply
any pre-patches/test-patches/whatever.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
