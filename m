Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281181AbRKLX2I>; Mon, 12 Nov 2001 18:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281185AbRKLX2A>; Mon, 12 Nov 2001 18:28:00 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:23744 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S281181AbRKLX1r>;
	Mon, 12 Nov 2001 18:27:47 -0500
Date: Tue, 13 Nov 2001 00:27:00 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Frank de Lange <lkml-frank@unternet.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Abysmal interactive performance on 2.4.linus
In-Reply-To: <20011112152123.C32099@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.21.0111130025130.26022-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001, Mike Fedyk wrote:

> On Mon, Nov 12, 2001 at 11:56:42PM +0100, Frank de Lange wrote:
> [snip]
> > Seems that reiserfs is the common factor here, at least on my box. This is a 35
> > GB reiserfs filesystem, app 80% used, both large and small files.
> > 
> > As said in my previous message, the numbers themselves don't mean squat. It is
> > the large delays (the fact that user+sys <<< real) which are the problem here.
> > 
> > Any other magic anyone wants me to perform? Hans, you reading this?
> > 
> 
> Do you see/hear a lot of seeking happing during the delays?

Yup this is probably what's happening to me. I didn't think a harddrive
could do so many seeks so fast :)

> If so, your Reiser partition is probably fragmented to hell...

:(

> IIRC this problem is being looked at, check some archives of lkml or reiser...

Ok, thanks

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

