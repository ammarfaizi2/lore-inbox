Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283655AbRLDOog>; Tue, 4 Dec 2001 09:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283473AbRLDOmq>; Tue, 4 Dec 2001 09:42:46 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:55218
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S283123AbRLDMbb>; Tue, 4 Dec 2001 07:31:31 -0500
Date: Tue, 4 Dec 2001 07:21:22 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, Keith Owens <kaos@ocs.com.au>,
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204072122.A11746@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20011204065212.A10990@thyrsus.com> <E16BEat-0001w7-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16BEat-0001w7-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Dec 04, 2001 at 12:22:39PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > Unfortunately, the syntax of CML1 is rebarbative, and its imperative 
> > semantics cannot be mechanically translated to CML2's declarative 
> > semantics by any means I'm aware of.
> 
> The dependancy tree from CML1 is not that hard to obtain. It's not quite
> complete or correct though

That's right -- and the devil would be in the incomplete/incorrect
details. Areas of special pain: (1) cross-directory constraints, (2)
derivations, (3) multiple port tree apexes.  These are all areas where
CML1 has design flaws that human coders get around by applying
higher-level knowledge of a kind a mechanical translator couldn't
have.

This is, alas, one of those cases where the first 90% of the problem looks 
easy and the last 10% turns ought to be nigh-impossible -- and the
first 90% is useless without the last 10%.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Among the many misdeeds of British rule in India, history will look
upon the Act depriving a whole nation of arms as the blackest."
        -- Mohandas Ghandhi, An Autobiography, pg 446
