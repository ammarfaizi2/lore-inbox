Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288141AbSACCer>; Wed, 2 Jan 2002 21:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287956AbSACCeh>; Wed, 2 Jan 2002 21:34:37 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:48004
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288141AbSACCeX>; Wed, 2 Jan 2002 21:34:23 -0500
Date: Wed, 2 Jan 2002 21:20:56 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Lionel Bouton <Lionel.Bouton@free.fr>
Cc: Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102212056.F21788@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Lionel Bouton <Lionel.Bouton@free.fr>, Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C338DCC.3020707@free.fr> <Pine.LNX.4.33.0201022349200.427-100000@Appserv.suse.de> <20020102174824.A21408@thyrsus.com> <3C339681.3080100@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C339681.3080100@free.fr>; from Lionel.Bouton@free.fr on Thu, Jan 03, 2002 at 12:23:45AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lionel Bouton <Lionel.Bouton@free.fr>:
> Eric I see your point now. But stop me if I don't get the idea behind 
> your autoconfigurator :
> Guessing the hardware configuration is done in order to ease the whole 
> configuration process. After polishing the configuration - no need for 
> root priviledge - the user start the build process that doesn't need 
> root priviledge either.
> But when the user gets the resulting kernel how does (s)he avoid suing 
> to root in order to *install* it and its modules ?
> I'm not familiar with people configuring and compiling kernels for 
> pleasure. They usually want to boot it...
> 
> Your whole point here is not to avoid several su instead of 1?

That's actually *precisely* the point.  The user should not have to 
go root for anything before the `make install' point.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The whole of the Bill [of Rights] is a declaration of the right of the
people at large or considered as individuals...  It establishes some
rights of the individual as unalienable and which consequently, no
majority has a right to deprive them of.
         -- Albert Gallatin, Oct 7 1789
