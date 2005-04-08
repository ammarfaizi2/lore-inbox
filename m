Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262721AbVDHHT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbVDHHT4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 03:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbVDHHTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:19:55 -0400
Received: from heavensgate.debian.net ([213.41.173.23]:48794 "EHLO
	heavensgate.debian.net") by vger.kernel.org with ESMTP
	id S262721AbVDHHTo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:19:44 -0400
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
	copyright notice.
From: Josselin Mouette <joss@debian.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050407210722.GC4325@stusta.de>
References: <20050404100929.GA23921@pegasos>
	 <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos>
	 <20050404175130.GA11257@kroah.com>
	 <20050404190518.GA17087@wonderland.linux.it>
	 <20050404193204.GD4087@stusta.de>
	 <1112709907.30856.17.camel@silicium.ccc.cea.fr>
	 <20050407210722.GC4325@stusta.de>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 08 Apr 2005 09:22:00 +0200
Message-Id: <1112944920.11027.13.camel@silicium.ccc.cea.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 07 avril 2005 à 23:07 +0200, Adrian Bunk a écrit :
> > You are mixing apples and oranges. The fact that the GFDL sucks has
> > nothing to do with the firmware issue. With the current situation of
> > firmwares in the kernel, it is illegal to redistribute binary images of
> > the kernel. Full stop. End of story. Bye bye. Redhat and SuSE may still
> > be willing to distribute such binary images, but it isn't our problem.
> 
> It's a grey area.
> 
> debian-legal did pick one of the possible opinions on this matter.

When there are several possible interpretations, you have to pick up the
more conservative one, as it's not up to us to make the interpretation,
but to a court.

> Is it true, that the removal of much of the documentation in Debian is 
> scheduled soon because it's covered by the GFDL, that this is called an 
> "editorial change", and that Debian doesn't actually care that this will 
> e.g. remove all documentation about available options of the standard C 
> compiler used by and shipped with Debian?

The situation changed only in the mind of the person who was the release
manager at that time. The "old" wording is "Debian will remain 100% free
software", and he understood that as "100% of software in Debian will
remain free". The common interpretation is that this wording doesn't
allow GFDL documentation either. The fact these documents are very
useful is irrelevant: the GFDL is a real piece of crap, only a few fools
at the FSF are really arguing it is a free license.

Instead of babbling, some people have started to discuss this with
upstream, and are trying to come up with a GPLed documentation for GCC.
This is much more constructive than repeating again and again "Bleh,
Debian are a bunch of bigots who don't care of the compiler being
documented."

> Is it true, that Debian will leave users with hardware affected by the 
> firmware problem without a working installer in Debian 3.1?

The case of hardware really needing a firwmare to work *and* needed at
installation time is rare. I've only heard of some tg3-based cards. Most
of them will work without the firmware, and for the few remaining ones,
it only means network installation won't work.

> The point is simply, that Debian does more and more look dogmatic at 
> it's definition of "free software" without caring about the effects to 
> it's users.

Being careless in the definition of "free software" is a real disservice
to users. It makes them rely on e.g. non-free documentation for everyday
use.

> As a contrast, read the discussion between Christoph and Arjan in a part 
> of this thread how to move firmware out of kernel drivers without 
> problems for the users. This might not happen today, but it's better for 
> the users.

Some Debian developers have been writing such patches so that we can
still run Linux on this hardware, long before the topic was raised on
the LKML.
-- 
 .''`.           Josselin Mouette        /\./\
: :' :           josselin.mouette@ens-lyon.org
`. `'                        joss@debian.org
   `-  Debian GNU/Linux -- The power of freedom

