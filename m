Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284997AbRLKOXy>; Tue, 11 Dec 2001 09:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284996AbRLKOXo>; Tue, 11 Dec 2001 09:23:44 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:32592 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S284987AbRLKOX3>; Tue, 11 Dec 2001 09:23:29 -0500
Date: Tue, 11 Dec 2001 15:23:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
Message-ID: <20011211152356.I4801@athlon.random>
In-Reply-To: <20011211144223.E4801@athlon.random> <Pine.LNX.4.33L.0112111157410.4079-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33L.0112111157410.4079-100000@imladris.surriel.com>; from riel@conectiva.com.br on Tue, Dec 11, 2001 at 11:59:06AM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001 at 11:59:06AM -0200, Rik van Riel wrote:
> On Tue, 11 Dec 2001, Andrea Arcangeli wrote:
> 
> > > The VM code lacks comments, and nobody except yourself understands
> > > what it is supposed to be doing.  That's a bug, don't you think?
> >
> > Lack of documentation is not a bug, period. Also it's not true that
> > I'm the only one who understands it.
> 
> Without documentation, you can only know what the code
> does, never what it is supposed to do or why it does it.

I only care about "what the code does" and "what are the results and the
bugreports".  Anything else is vaopurware and I don't care about that.

As said I wrote some documentation on the VM for my last speech at the
one of the most important italian linux events, it explains the basic
design. It should be published on their webside as soon as I find the
time to send them the slides. I can post a link once it will be online.
It shoud allow non VM-developers to understand the logic behind the VM
algorithm, but understanding those slides it's far from allowing anyone
to hack the VM.

I _totally_ agree with Linus when he said "real world is totally
dominated by the implementation details". I was thinking this way before
reading his recent email to l-k (however I totally disagree about
evolution being random and the other kernel-offtopic part of such thread :).

For developers the real freedom is the code, not the documentation and
the code is there. And I think it's much easier to understand the
current code (ok I'm biased, but still I believe for outsiders it's
simpler).

Andrea
