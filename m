Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268891AbRG0Qu3>; Fri, 27 Jul 2001 12:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268894AbRG0QuN>; Fri, 27 Jul 2001 12:50:13 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:37391 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268892AbRG0Qt5>; Fri, 27 Jul 2001 12:49:57 -0400
Message-ID: <3B619B7E.379636F2@namesys.com>
Date: Fri, 27 Jul 2001 20:49:02 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        kernel <linux-kernel@vger.kernel.org>, Chris Mason <mason@suse.com>
Subject: Early Flush
In-Reply-To: <Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl> <0107271706460G.00285@starship> <3B6189E2.77F072DD@namesys.com> <0107271830220J.00285@starship>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Daniel Phillips wrote:
> 
> On Friday 27 July 2001 17:33, Hans Reiser wrote:
> > Daniel Phillips wrote:
> > > On Friday 27 July 2001 16:18, Joshua Schmidlkofer wrote:
> > > > I've almost quit using reiser, because everytime I have a power
> > > > outage, the last 2 or three files that I've editted, even ones
> > > > that I haven't touched in a while, will usually be hopelessly
> > > > corrupted.
> > >
> > > My early flush patch will fix this, or at least it will if I get
> > > together with the ReiserFS guys and figure out how to integrate
> > > their flushing mechanism with the standard bdflush.  Or they could
> > > incorporate the ideas from my early flush in their own flush
> > > daemon, though generalizing the standard flush would have more
> > > value in the long run.
> >
> > Can you describe early flush?
> 
> The idea is to do what amounts to a sync within a tenth of a second of
> disk bandwidth usage falling below a certain threshhold.
> 
> The original posts/patches are here:
> 
>     [RFC] Early flush (was: spindown)
>     [RFC] Early flush: new, improved (updated)
> 
> and there are long threads attached to each of them.  The clearest
> explanation is probably Jonathan Corbet's writeup on lwn:
> 
>    http://lwn.net/2001/0628/kernel.php3
> 
> (Thanks, Jonathan, I often get the feeling I understand what I actually
> did only *after* reading your writeups:-)
> 
> The second of the two patches needs more work - I think I goofed on
> some needed "volatile" handling, see the current flam^H^H^H^H thread
> about that.
> 
> --
> Daniel
Daniel, what you have done is something that I have wanted and believed in for a long time.

Spell out what you need from us and we will support you.

Hans
