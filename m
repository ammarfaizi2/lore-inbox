Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281546AbRLDRRq>; Tue, 4 Dec 2001 12:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281214AbRLDRQH>; Tue, 4 Dec 2001 12:16:07 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:24756
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S281530AbRLDROn>; Tue, 4 Dec 2001 12:14:43 -0500
Date: Tue, 4 Dec 2001 12:06:12 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Giacomo Catenazzi <cate@dplanet.ch>
Cc: David Woodhouse <dwmw2@infradead.org>, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204120612.B16578@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Giacomo Catenazzi <cate@dplanet.ch>,
	David Woodhouse <dwmw2@infradead.org>,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <1861.1007341572@kao2.melbourne.sgi.com> <20011204131136.B6051@caldera.de> <20011204072808.A11867@thyrsus.com> <20011204133932.A8805@caldera.de> <20011204074815.A12231@thyrsus.com> <20011204140050.A10691@caldera.de> <20011204081640.A12658@thyrsus.com> <20011204142958.A14069@caldera.de> <19642.1007484062@redhat.com> <3C0CFF5F.3090404@dplanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0CFF5F.3090404@dplanet.ch>; from cate@dplanet.ch on Tue, Dec 04, 2001 at 05:52:47PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo Catenazzi <cate@dplanet.ch>:
> I don't think esr changed non problematic rules, but one:
> all rules without help become automatically dependent to
> CONFIG_EXPERIMENTAL. I don't like it, but I understand why
> he makes this decision.

No, it's CONFIG_EXPERT.  And this change is not wired in.  Comment
out this declaration in the top-level rulesfile: 

condition nohelp on EXPERT

and it reverts to old behavior.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The conclusion is thus inescapable that the history, concept, and 
wording of the second amendment to the Constitution of the United 
States, as well as its interpretation by every major commentator and 
court in the first half-century after its ratification, indicates 
that what is protected is an individual right of a private citizen 
to own and carry firearms in a peaceful manner.
         -- Report of the Subcommittee On The Constitution of the Committee On 
            The Judiciary, United States Senate, 97th Congress, second session 
            (February, 1982), SuDoc# Y4.J 89/2: Ar 5/5
