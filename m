Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283159AbRK2LHO>; Thu, 29 Nov 2001 06:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283168AbRK2LHE>; Thu, 29 Nov 2001 06:07:04 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:62602
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S283166AbRK2LG6>; Thu, 29 Nov 2001 06:06:58 -0500
Date: Thu, 29 Nov 2001 06:00:48 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CML 1.9.2 is available
Message-ID: <20011129060048.A11216@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version is always available at http://www.tuxedo.org/~esr/cml2/

Release 1.9.2: Thu Nov 29 05:43:40 EST 2001
	* Rulebase and help sync with 2.4.17-pre1/2.5.1-pre3.
	* Rulebase now includes a KERNEL symbol usable in visibilities 
	  so it can track both sides of the 2.4/2.5 fork.
	* Search no longer disables suppression of invisible symbols;
	  they still show up on the results menu, however.
	* Fix for a bug in the compiler's type deduction for derived symbols.
	* Attempted fix for a visibility bug reported by Keith Owens.

No bugs pending (assuming the fix for Keith's visibility bug works).

Keith has pointed out a weakness in the language -- there's no way to make
the default value of a choices menu dependent on the architecture (an issue
for things like kcore format).  I am meditating on this.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

As the Founding Fathers knew well, a government that does not trust its honest,
law-abiding, taxpaying citizens with the means of self-defense is not itself
worthy of trust. Laws disarming honest citizens proclaim that the government
is the master, not the servant, of the people.
        -- Jeff Snyder
