Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130446AbREHHAn>; Tue, 8 May 2001 03:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131205AbREHHAe>; Tue, 8 May 2001 03:00:34 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:50956 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S130446AbREHHA3>;
	Tue, 8 May 2001 03:00:29 -0400
Date: Tue, 8 May 2001 03:00:35 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Weinehall <tao@acc.umu.se>
Cc: Tom Rini <trini@kernel.crashing.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010508030035.A15697@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Weinehall <tao@acc.umu.se>,
	Tom Rini <trini@kernel.crashing.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010505192731.A2374@thyrsus.com> <E14wO7g-000240-00@the-village.bc.nu> <20010507105950.A771@opus.bloom.county> <20010507213140.I16535@thyrsus.com> <20010507184315.A2378@opus.bloom.county> <20010507215618.B21552@thyrsus.com> <20010508085739.A17485@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010508085739.A17485@khan.acc.umu.se>; from tao@acc.umu.se on Tue, May 08, 2001 at 08:57:40AM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall <tao@acc.umu.se>:
> > require X86 and PARPORT implies PARPORT_PC
> > unless X86==n suppress PARPORT_PC
> > 
> > which forces PARPORT_PC==y and makes the question invisible on X86
> > machines, but leaves the question visible on all others.
> 
> Yes, but there are quite a lot of people who don't want
> parport/serial/whatever compiled into their kernels at all,
> eventhough they have an x86. Think low-memory systems or similar.

That's OK.  Neither of these constraints says PARPORT must be compiled in.
Look at the conditionals carefully.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"...The Bill of Rights is a literal and absolute document. The First
Amendment doesn't say you have a right to speak out unless the
government has a 'compelling interest' in censoring the Internet. The
Second Amendment doesn't say you have the right to keep and bear arms
until some madman plants a bomb. The Fourth Amendment doesn't say you
have the right to be secure from search and seizure unless some FBI
agent thinks you fit the profile of a terrorist. The government has no
right to interfere with any of these freedoms under any circumstances."
	-- Harry Browne, 1996 USA presidential candidate, Libertarian Party
