Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263749AbRFLWx0>; Tue, 12 Jun 2001 18:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbRFLWxG>; Tue, 12 Jun 2001 18:53:06 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:50443 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263749AbRFLWwy>; Tue, 12 Jun 2001 18:52:54 -0400
Date: Tue, 12 Jun 2001 15:51:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alex Deucher <adeucher@UU.NET>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.5-ac12] New Sony Vaio Motion Eye camera driver
In-Reply-To: <3B26827B.5CF40115@uu.net>
Message-ID: <Pine.LNX.4.31.0106121549130.4477-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Jun 2001, Alex Deucher wrote:
>
> As far as I know they have not been integrated into the Xfree tree.  I
> believe there were some disagreements about extending the Xv API since
> GATOS added some extentions to support the AIW video capture cards.  I
> suppose someone could try and submit a patch again and see if they'll
> take it.

I got just the YUV code from Gatos, and a few months ago it took less than
an hour to merge just that part (and most of that was compiling and
testing).

The rest of Gatos is obviously more experimental, but the YUV code looks
quite sane.

> Also there is some work on a new XvMC interface that would allow for
> extended DVD acceleration.

Yes. Although I hope it's going to be XvMPG2 or something - some cards
literally do all of the mpeg2 stuff, not just parts of it, and limiting
yourself to just the motion comp is limiting the protocol quite badly.

		Linus

