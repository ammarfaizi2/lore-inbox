Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135202AbRDRPJK>; Wed, 18 Apr 2001 11:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135204AbRDRPJB>; Wed, 18 Apr 2001 11:09:01 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:25350 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135202AbRDRPIs>;
	Wed, 18 Apr 2001 11:08:48 -0400
Date: Wed, 18 Apr 2001 11:09:20 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, torvalds@transmeta.com,
        axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Supplying missing entries for Configure.help -- corrections
Message-ID: <20010418110920.A21430@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>, torvalds@transmeta.com,
	axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <200104181335.f3IDZrq17002@snark.thyrsus.com> <E14ptK2-0004ts-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14ptK2-0004ts-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Apr 18, 2001 at 03:52:43PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> >  Support for Cobalt Micro Server
> >  CONFIG_COBALT_MICRO_SERVER
> > -  Support for ARM-based Cobalt boxes (they have been bought by Sun and
>  +  Support for MIPS-based Cobalt boxes (they have been bought by Sun and
> 
> Cobalt support was removed in the 2.4.4pre4 tree. Its not been maintained
> for 2.4 because nobody is interested in doing the job

OK, I'll add that and COBALT_28 to my list of dead symbols to be removed.
I'm working on patches to do that now.

Have you applied Steven Cole's version of my Configure.help patches
1-5 yet?  If not, would you prefer to see further incremental patches
or a consolidated config-namespace cleanup patch including both
help additions and dead-symbol removals?  I can do either; please let me
know which would make life easier for you.

(Intentionally, none of this is CML2 stuff.)
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Every election is a sort of advance auction sale of stolen goods. 
	-- H.L. Mencken 
