Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133051AbRDLBtz>; Wed, 11 Apr 2001 21:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133044AbRDLBtp>; Wed, 11 Apr 2001 21:49:45 -0400
Received: from zeus.kernel.org ([209.10.41.242]:3780 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S133047AbRDLBth>;
	Wed, 11 Apr 2001 21:49:37 -0400
Date: Wed, 11 Apr 2001 18:01:38 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: esr@thyrsus.com, Michael Elizabeth Chastain <chastain@cygnus.com>,
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: CML2 1.0.0 release announcement
Message-ID: <20010411180138.A27597@vitelus.com>
In-Reply-To: <200104112056.NAA20872@bosch.cygnus.com> <20010411174609.A8410@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010411174609.A8410@thyrsus.com>; from esr@thyrsus.com on Wed, Apr 11, 2001 at 05:46:09PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 05:46:09PM -0400, esr@thyrsus.com wrote:
> The speed problem now is in the configurator itself.
> One of my post-1.0.0 challenges is to profile and tune the configurator
> code to within an inch of its life.

Maybe you could kill two birds with one stone by calling 1.0.0 the
prototype and rewriting it in C. Not only would this improve speed
(algorithmic improvements would also be welcome...), but it would
remove the pythonic obstacle to its adoption as a standard. Many,
including me, oppose writing the standard configurator in Python. I
don't have Python installed and I'm not going to install yet another
scripting language just because ESR likes it. Yes, we know about
freeze support, but aren't convinced that it will do well at this. It
seems that a native C configurator will be both faster and more
portable (accross distributions and mindsets) than something requiring
a recent version of SuperEasyInterpretedProgrammingLanguage 2.0.

I know that you're reluctant to make the port, but you don't need to
be too shy to ask for help. Few people on this list are afraid of C.
If you're too lazy to implement CML2 in a standard, popular, robust
language, heck, tell us, and we may be able to help you out.

Sorry for the anti-Python flamage. I'm sure that it has its uses. I,
however, don't view it as appropriate for configuration of an integral
component of a GNU/Linux system. I want to make the view clear to aid
Linus with his descision and to encourage a C port of CML2, which
languages aside looks like a good format and concept BTW.
