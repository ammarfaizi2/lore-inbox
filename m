Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269381AbUIBXyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269381AbUIBXyq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269390AbUIBXyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:54:20 -0400
Received: from the-village.bc.nu ([81.2.110.252]:9106 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269381AbUIBXwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:52:49 -0400
Subject: Re: The argument for fs assistance in handling archives (was:
	silent semantic changes with reiser4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Huey <bhuey@lnxw.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20040902215627.GA15688@nietzsche.lynx.com>
References: <20040826150202.GE5733@mail.shareable.org>
	 <200408282314.i7SNErYv003270@localhost.localdomain>
	 <20040901200806.GC31934@mail.shareable.org>
	 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
	 <1094118362.4847.23.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409021045210.2295@ppc970.osdl.org>
	 <1094150760.5809.30.camel@localhost.localdomain>
	 <20040902215627.GA15688@nietzsche.lynx.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094165289.6163.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 23:48:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-02 at 22:56, Bill Huey wrote:
> It also depends on who you ask. I can't take a lot of the mainstream
> X folks serious since they are still using integer math as parameters

The X folks know what they are doing. Modern X has a complete
compositing model. Modern X has a superb font handling system. Nobody
broke anything along the way. The new API's can be mixed with the old,
there are good fallbacks for old servers.

In fact they are so good at it that most people don't notice beyond the
fact their UI looks better than before.

That is how you do change *right*

> more dynamic systems. And the advent of XML (basically a primitive and
> flat model of what Hans is doing) for .NET style systems are going to

I see you don't really get XML either. XML is just an encoding. Its
larger and prettier than ASN.1 and easier to hack about with perl. You
can do the same thing with lisp lists for that matter.

> have been lost to older commericial interests (Microsoft Win32) and that
> has wiped out the fundamental classic computer science backing this from
> history. This simple "MP3 metadata" stuff is a very superficial example
> of how something like this is used.

The trouble with computer science is that most of it sucks in the real
world. We don't write our OS's in Standard ML, we don't implement some
of the provably secure capability computing models. At the end of the
day they are neat, elegant and useless to real people.

> Unix folks tend to forget that since they either have never done this
> kind of programming or never understood why this existed in the first
> place. It's about a top-down methodology effecting the entire design of
> the software system, not just purity Unix. If it can be integrate
> smoothly into the system, then it should IMO.

The Unix world succeeded because Unix (at least in v7 days) was the
other way around to every other grungy OS on the planet. It had only
thing things it needed. I've used some of the grungy crawly horrors that
were its rivals and there is a reason they don't exist any more.

I would sum up the essence of the unix kernel side as
	- Does only what it must do
	- "Makes the usual easy makes the unusual possible"
	- Has an API that is small enough for developers to learn
	  easily (an API so good every other OS promptly ripped it off)
	  People forget the worlds of SYS$QIO, RMS, FCB's and the like

Its worked remarkably well for a very very long time, and most of the
nasties have come from people trying to break that model or not
understanding it.

Alan
