Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288143AbSACCdR>; Wed, 2 Jan 2002 21:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287956AbSACCdH>; Wed, 2 Jan 2002 21:33:07 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:46980
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288143AbSACCcz>; Wed, 2 Jan 2002 21:32:55 -0500
Date: Wed, 2 Jan 2002 21:19:23 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Dave Jones <davej@suse.de>
Cc: Lionel Bouton <Lionel.Bouton@free.fr>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102211923.E21788@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C3398E1.4080904@free.fr> <Pine.LNX.4.33.0201030035230.5131-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201030035230.5131-100000@Appserv.suse.de>; from davej@suse.de on Thu, Jan 03, 2002 at 12:37:53AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de>:
> On Thu, 3 Jan 2002, Lionel Bouton wrote:
> 
> > > If /proc/dmi were to go in soon, at least I *could* rely on it in 2.6.
> > If in rc.sysinit a call to "dmidecode > /var/run/dmi" were to go in the
> > user space 2.6 kernel build dependancies in Documentation/Changes,
> > you'll be on the same level.
> 
> Could even be done as part of Al's early-userspace, thus removing the
> reliance upon vendors to do it.  Does imply that you're building 2.6 on a
> 2.6 enabled distro though.

Tell me more.  This begins to sound potentially interesting -- I can
certainly live with knowing the state of the DMI tables as of the time
of last boot, as long as it's in a fixed location that the
autoconfigurator can count on.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Gun Control: The theory that a woman found dead in an alley, raped and
strangled with her panty hose, is somehow morally superior to a
woman explaining to police how her attacker got that fatal bullet wound.
	-- L. Neil Smith
