Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274990AbRKDTux>; Sun, 4 Nov 2001 14:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275224AbRKDTuo>; Sun, 4 Nov 2001 14:50:44 -0500
Received: from unthought.net ([212.97.129.24]:59096 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S274990AbRKDTub>;
	Sun, 4 Nov 2001 14:50:31 -0500
Date: Sun, 4 Nov 2001 20:50:30 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: John Levon <moz@compsoc.man.ac.uk>, linux-kernel@vger.kernel.org,
        Daniel Phillips <phillips@bonn-fries.net>, Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104205030.P14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Alexander Viro <viro@math.psu.edu>,
	John Levon <moz@compsoc.man.ac.uk>, linux-kernel@vger.kernel.org,
	Daniel Phillips <phillips@bonn-fries.net>,
	Tim Jansen <tim@tjansen.de>
In-Reply-To: <20011104200452.L14001@unthought.net> <Pine.GSO.4.21.0111041413390.21449-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0111041413390.21449-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Nov 04, 2001 at 02:29:06PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 02:29:06PM -0500, Alexander Viro wrote:
> 
> 
> On Sun, 4 Nov 2001, [iso-8859-1] Jakob %stergaard wrote:
> 
> > I'm a little scared when our VFS guy claims he never heard of excellent
> > programmers using scanf in a way that led to parse errors.
> 
> I've seen excellent programmers fscking up use of && and ||.
> 
> I've also seen quite a few guys coming (from their experience) to
> the conclusions that look an awful lot similar to mine.  Like, say it,
> dmr and ken.  Or Linus.  Or Rob Pike.  Or Brian Kernighan.
> 
> And frankly, when I hear about "typed" interfaces, two things come to
> mind - "typed files" and CORBA.  Both - architectural failures.

Architectural failures like "C" or "C++" for example.

Strong type information (in one form or the other) is absolutely fundamental
for achieving correctness in this kind of software.

You can't just have a "data thingy" and hope your "operator thingys" do
what you suppose they do, and that your "storage thingy" has enough room
for what you shovel into it.

C has types for a reason.  C++ improved the type system for a reason.  Perl
and PHP programs have run-time failures for a reason.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
