Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283270AbRLDRaG>; Tue, 4 Dec 2001 12:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281555AbRLDR3w>; Tue, 4 Dec 2001 12:29:52 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:31412
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S281530AbRLDR21>; Tue, 4 Dec 2001 12:28:27 -0500
Date: Tue, 4 Dec 2001 12:19:50 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@caldera.de>,
        Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204121950.E16578@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@caldera.de>,
	Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
	torvalds@transmeta.com
In-Reply-To: <20011204173309.A10746@emma1.emma.line.org> <E16BJ9v-0002ii-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16BJ9v-0002ii-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Dec 04, 2001 at 05:15:07PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > Creating a dependency on Python? Is a non-issue. Current systems that
> > are to run 2.5 or 2.6 are bloated beyond belief by glibc already, Python
> > is nice and it does not create such unmaintainable mess. Whether
> 
> Python2 - which means most users dont have it.

I'm pretty sure that's true any more, Alan.  Red Hat shipped Python 2 in
7.1, so the RPM-based distros like KRUD and Mandrake have had it for
seven months. Debian had it before that.   

Requiring 2.0 looked aggressive when I did it, but it wasn't -- I could
safely project that it would be deployed everywhere except on a set of
measure zero by the time the actual cutover happened.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Both oligarch and tyrant mistrust the people, 
and therefore deprive them of arms."
	--Aristotle
