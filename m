Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263603AbREYHH7>; Fri, 25 May 2001 03:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263604AbREYHHt>; Fri, 25 May 2001 03:07:49 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:527 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S263603AbREYHHj>;
	Fri, 25 May 2001 03:07:39 -0400
Date: Fri, 25 May 2001 03:10:15 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: Configure.help entries wanted
Message-ID: <20010525031015.A5828@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010525023558.B5622@thyrsus.com> <24758.990773964@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <24758.990773964@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Fri, May 25, 2001 at 04:59:24PM +1000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au>:
> Early ones for compare-and-exchange.  AFAIK no recent (Itanium B3 or
> later) cpu has these problems.

Entry now reads:

IA64 compare-and-exchange bug checking
CONFIG_IA64_DEBUG_CMPXCHG
  Selecting this option turns on bug checking for the IA64
  compare-and-exchange instructions.  This is slow!  Itaniums
  from step B3 or later don't have this problem. If you're unsure,
  select N.
 
> This is software, not hardware, debugging.  It saves addresses to help
> track down spinlock problems.

Entry now reads:

IA64 IRQ bug checking
CONFIG_IA64_DEBUG_IRQ
  Selecting this option turns on bug checking for the IA64 irq_save and
  restore instructions.  It's useful for tracking down spinlock problems,
  but slow!  If you're unsure, select N.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

In recent years it has been suggested that the Second Amendment
protects the "collective" right of states to maintain militias, while
it does not protect the right of "the people" to keep and bear arms.
If anyone entertained this notion in the period during which the
Constitution and the Bill of Rights were debated and ratified, it
remains one of the most closely guarded secrets of the eighteenth
century, for no known writing surviving from the period between 1787
and 1791 states such a thesis.
        -- Stephen P. Halbrook, "That Every Man Be Armed", 1984
