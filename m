Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131257AbRAKEXj>; Wed, 10 Jan 2001 23:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131591AbRAKEXa>; Wed, 10 Jan 2001 23:23:30 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:14603 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131257AbRAKEXS>; Wed, 10 Jan 2001 23:23:18 -0500
Date: Wed, 10 Jan 2001 20:23:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David L. Parsley" <parsley@linuxjedi.org>
cc: "Adam J. Richter" <adam@yggdrasil.com>, parsley@roanoke.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one-liner fix for bforget() honoring BH_Protected; was:
 Re:  Patch (repost): cramfs memory corruption fix
In-Reply-To: <3A5CF0AA.1AC1E753@linuxjedi.org>
Message-ID: <Pine.LNX.4.10.10101102022470.1083-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jan 2001, David L. Parsley wrote:
> 
> Yup, I backed out Adam's one-liner in favor of the attached one-liner. 
> Tested on 2.4.0, but should patch cleanly to just about anything. ;-)
> 
> BTW Linus - you were of course right on the cramfs wanting 4096
> blocksize... but without this fix, that doesn't matter much. ;-)

So everything works the way you want it now? Just checking that there
aren't any outstanding issues..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
