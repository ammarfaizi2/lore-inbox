Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261254AbRFMNKG>; Wed, 13 Jun 2001 09:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbRFMNJ4>; Wed, 13 Jun 2001 09:09:56 -0400
Received: from cmr2.ash.ops.us.uu.net ([198.5.241.40]:61133 "EHLO
	cmr2.ash.ops.us.uu.net") by vger.kernel.org with ESMTP
	id <S261254AbRFMNJp>; Wed, 13 Jun 2001 09:09:45 -0400
Message-ID: <3B276615.7B175F72@uu.net>
Date: Wed, 13 Jun 2001 09:09:41 -0400
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.5-ac12] New Sony Vaio Motion Eye camera driver
In-Reply-To: <Pine.LNX.4.31.0106121549130.4477-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I actually heard from one of the xfree developers last night that the
merge of the the YUV stuff at least is in progress.  As I recall I think
XvMC was for general media controls, but I could be wrong, it's been a
while.

Alex

Linus Torvalds wrote:
> 
> On Tue, 12 Jun 2001, Alex Deucher wrote:
> >
> > As far as I know they have not been integrated into the Xfree tree.  I
> > believe there were some disagreements about extending the Xv API since
> > GATOS added some extentions to support the AIW video capture cards.  I
> > suppose someone could try and submit a patch again and see if they'll
> > take it.
> 
> I got just the YUV code from Gatos, and a few months ago it took less than
> an hour to merge just that part (and most of that was compiling and
> testing).
> 
> The rest of Gatos is obviously more experimental, but the YUV code looks
> quite sane.
> 
> > Also there is some work on a new XvMC interface that would allow for
> > extended DVD acceleration.
> 
> Yes. Although I hope it's going to be XvMPG2 or something - some cards
> literally do all of the mpeg2 stuff, not just parts of it, and limiting
> yourself to just the motion comp is limiting the protocol quite badly.
> 
>                 Linus
