Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133013AbRDKVpG>; Wed, 11 Apr 2001 17:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133006AbRDKVoy>; Wed, 11 Apr 2001 17:44:54 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:14389 "EHLO
	golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S133013AbRDKVoo>; Wed, 11 Apr 2001 17:44:44 -0400
Date: Wed, 11 Apr 2001 17:46:09 -0400
From: esr@thyrsus.com
To: Michael Elizabeth Chastain <chastain@cygnus.com>
Cc: davej@suse.de, hch@caldera.de, esr@snark.thyrsus.com,
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: CML2 1.0.0 release announcement
Message-ID: <20010411174609.A8410@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com,
	Michael Elizabeth Chastain <chastain@cygnus.com>, davej@suse.de,
	hch@caldera.de, esr@snark.thyrsus.com,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200104112056.NAA20872@bosch.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104112056.NAA20872@bosch.cygnus.com>; from chastain@cygnus.com on Wed, Apr 11, 2001 at 01:56:19PM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Elizabeth Chastain <chastain@cygnus.com>:
> I like mconfig, but I like CML2 better.

Reminder for the rest of you: Michael *wrote* mconfig.

> My primary reason is that ESR has more time to work on CML2 than I do
> on mconfig.  And speed problems are often the easiest problems to solve.
> 
> Eric did some performance analysis.  If I recall correctly, all but 1
> or 2 seconds of CML2's runtime is in the parser.  He has rewritten the
> parser once.  Maybe someone needs to rewrite it again, maybe propagate
> some changes into the language spec to make it easier to parse, maybe
> rewrite from Python to C.

The *language compiler's* runtime got cut in half when I hand-rolled a
parser for it.  The speed problem now is in the configurator itself.
One of my post-1.0.0 challenges is to profile and tune the configurator
code to within an inch of its life.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

'Faith' means not _wanting_ to know what is true.
	-- Nietzsche, Der Antichrist
