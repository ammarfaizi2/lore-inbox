Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287903AbSACCar>; Wed, 2 Jan 2002 21:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287956AbSACCah>; Wed, 2 Jan 2002 21:30:37 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:44932
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287903AbSACCa3>; Wed, 2 Jan 2002 21:30:29 -0500
Date: Wed, 2 Jan 2002 21:17:02 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Lionel Bouton <Lionel.Bouton@free.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102211702.D21788@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Lionel Bouton <Lionel.Bouton@free.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102174824.A21408@thyrsus.com> <E16LubO-0005xF-00@the-village.bc.nu> <20020102180754.A21788@thyrsus.com> <3C3398E1.4080904@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C3398E1.4080904@free.fr>; from Lionel.Bouton@free.fr on Thu, Jan 03, 2002 at 12:33:53AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lionel Bouton <Lionel.Bouton@free.fr>:
> If in rc.sysinit a call to "dmidecode > /var/run/dmi" were to go in the 
> user space 2.6 kernel build dependancies in Documentation/Changes, 
> you'll be on the same level.

Problem is that would create another external dependency for the kernel
configuration process.  Unless you're proposing that dmidecode would live
with the kernel sources and get installed with them.

But I sense there might be the beginnings of a solution here...
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

'Faith' means not _wanting_ to know what is true.
	-- Nietzsche, Der Antichrist
