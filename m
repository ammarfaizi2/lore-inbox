Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261497AbRERTpz>; Fri, 18 May 2001 15:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261499AbRERTpp>; Fri, 18 May 2001 15:45:45 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:38153 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S261497AbRERTp2>;
	Fri, 18 May 2001 15:45:28 -0400
Date: Fri, 18 May 2001 15:44:07 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
Message-ID: <20010518154407.C17324@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010518142508.B16093@thyrsus.com> <E150pgP-0007Y5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E150pgP-0007Y5-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, May 18, 2001 at 08:13:04PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> Being able to turn CML2 into CML1 might be the more useful exercise.

That's...not a completely crazy idea.  Hmmm...

It might be possible to take a CML2 rulebase and generate a sort of stupid
jackleg CML1 translation of it.  The resulting config.in would be huge
and nasty, and would only work in forward sequence with no side-effect
computation, but you just might be able to get the old tools to parse it.

Again there's a technical problem with derivations.   Probably solvable.

But the real question is whether the old tools have enough value to be
worth the effort.  What problem are you trying to solve here?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

This would be the best of all possible worlds, if there were
no religion in it.
	-- John Adams, in a letter to Thomas Jefferson.
