Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293034AbSBVW5G>; Fri, 22 Feb 2002 17:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293035AbSBVW4v>; Fri, 22 Feb 2002 17:56:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59658 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293034AbSBVW4s>;
	Fri, 22 Feb 2002 17:56:48 -0500
Date: Fri, 22 Feb 2002 22:56:46 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Christer Weinigel <wingel@acolyte.hack.org>, linux-kernel@vger.kernel.org
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
Message-ID: <20020222225646.B5455@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Christer Weinigel <wingel@acolyte.hack.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202211134080.7649-100000@netfinity.realnet.co.sz> <3C74C8C7.25D7BCD@mandrakesoft.com> <20020221111910.57235F5B@acolyte.hack.org> <20020221115916.9FD5AF5B@acolyte.hack.org> <3C74E698.D3A0BFEB@mandrakesoft.com> <20020221125743.10F0BF5B@acolyte.hack.org> <3C74F410.B165E571@mandrakesoft.com> <20020222195708.EC152F5B@acolyte.hack.org> <20020222210107.A6828@fafner.intra.cogenit.fr> <20020222204823.235A6F5B@acolyte.hack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020222204823.235A6F5B@acolyte.hack.org>; from wingel@acolyte.hack.org on Fri, Feb 22, 2002 at 09:48:23PM +0100
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 09:48:23PM +0100, Christer Weinigel wrote:
> Francois Romieu wrote:
> > > I've gone through the drivers and tried to write down "established
> > > practice".  I guess I'm too wordy as usual, but it should be a
> > > starting point.  Please take a look at the attached file and if you or
...
> Implementations in the current drivers in the kernel tree:
> 
> Here I have tried to summarize what the different drivers support and
> where they do strange things compared to the other drivers.

Christer,
	Looks good.  Have you checked out the 2.4.18pre trees?  The
WDIOF_SETTIMEOUT flag is set for GETSTATUS in all of the drivers that
support WDIOC_GETTIMEOUT/WDIOC_SETTIMEOUT.  There are 8 or 9 of them,
but this did not seem to reflected in your document.

Joel

-- 

"The one important thing i have learned over the years is the difference
between taking one's work seriously and taking one's self seriously.  The
first is imperative and the second is disastrous."
	-Margot Fonteyn

			http://www.jlbec.org/
			jlbec@evilplan.org
