Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289858AbSAPE0G>; Tue, 15 Jan 2002 23:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290347AbSAPEZ4>; Tue, 15 Jan 2002 23:25:56 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:42881
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289858AbSAPEZo>; Tue, 15 Jan 2002 23:25:44 -0500
Date: Tue, 15 Jan 2002 23:09:24 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Tom Rini <trini@kernel.crashing.org>,
        Justin Carlson <justincarlson@cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020115230924.A5538@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
	Tom Rini <trini@kernel.crashing.org>,
	Justin Carlson <justincarlson@cmu.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020115013025.GA3814@cpe-24-221-152-185.az.sprintbbd.net> <197055869.1011134770@[195.224.237.69]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <197055869.1011134770@[195.224.237.69]>; from linux-kernel@alex.org.uk on Tue, Jan 15, 2002 at 10:46:11PM -0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>:
> & this has a seemingly obvious solution, which is, if the autoprobe
> stuff is selected, and, after presentation of the initial list
> of drivers, plus comments like 'Network card: none', 'Sound card: none',
> say 'We may have missed some stuff if you have an old computer, press
> Y if what we've detected doesn't find all your hardware', and if
> they press Y (only), select as modules every ISA driver except
> those, which when loaded on a system not containing the relevant
> card, can cause a hangup; thus deferring the autoprobing until
> boot time.

Not a bad idea, but it conflicts with one of the goals of 
`make autoconfigurator', which is completely hands-off opration.

Giacomo Catenazzi thinks he has collected enough "safe" probes to 
find effectively all ISA devices, by grovelling through various bits
of /proc.  So this problem may get solved directly.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Probably fewer than 2% of handguns and well under 1% of all guns will
ever be involved in a violent crime. Thus, the problem of criminal gun
violence is concentrated within a very small subset of gun owners,
indicating that gun control aimed at the general population faces a
serious needle-in-the-haystack problem.
	-- Gary Kleck, "Point Blank: Handgun Violence In America"
