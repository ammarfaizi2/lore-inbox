Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264550AbUD1AVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbUD1AVT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 20:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbUD1AVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 20:21:19 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:4501 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S264540AbUD1ATD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 20:19:03 -0400
Date: Wed, 28 Apr 2004 02:18:59 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: Tim Hockin <thockin@hockin.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <20040428000952.GA19522@hockin.org>
Message-ID: <Pine.LNX.4.44.0404280210510.16360-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Tim Hockin wrote:

> On Wed, Apr 28, 2004 at 01:59:08AM +0200, Robert M. Stockmann wrote:
> > > What the hell are you going on about?  Unnamed structures are a
> > > syntactical construct and have ZILCH to do with runtime.
> > 
> > I thought so too, until your semi open-source link kit is linked to that
> > brand-new linux kernel source tree, and at the same time the binary
> > components of your link-kit have become incompatible with that newer kernel. 
> 
> This is possible with any structure, named or unnamed.  It's called an
> ABI, and it's one of the reasons that binary modules suck.  It doesn't
> have *anything* to do with unnamed structures.  At all.  And if you think
> so, show me code.

here's a example :

http://www.promise.com/support/file/driver/1_fasttrak_tx4000_partial_source_1.00.0.19.zip

> 
> > > Opaque types have been available FOREVER.
> > 
> > sure, but can one qualify that as Open Source?
> 
> If used properly (and they are used in Linux, I believe) they can be very
> handy.  It's a non-sequiter.  no coding technique, no matter how
> incoherent, is incompatible with open source.

Opaque types should be no problem. However the complete definition must reside
somewhere _inside_ the complete source. Opaque types is even a bless, i agree.
It summarizes code to only reflect what is essential, instead of repeating
tedious and long struct types and defines. However if Opaque types are used
inside a partial_source tree, where the complete definition is hidden
inside the binary only closed source parts, then its the complete opposite
of what i would call a bless.

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

