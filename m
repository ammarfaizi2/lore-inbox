Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287134AbSABWsE>; Wed, 2 Jan 2002 17:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287141AbSABWrp>; Wed, 2 Jan 2002 17:47:45 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:900
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287144AbSABWrn>; Wed, 2 Jan 2002 17:47:43 -0500
Date: Wed, 2 Jan 2002 17:34:19 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102173419.A21165@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102172448.A18153@thyrsus.com> <E16LuDf-0005pp-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16LuDf-0005pp-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 02, 2002 at 10:50:47PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > But you're thinking like a developer, not a user.  The right question
> > is which approach requires the lowest level of *user* privilege to get
> > the job done.  Comparing world-readable /proc files versus a setuid app,
> > the answer is obvious.  This sort of thing is exactly what /proc is *for*.
> 
> Both require the same level of user privilege. 
> 
> 	cat /proc/wasteofmemory/dmi | dmidecoder
> v
> 	/sbin/dmidump | dmidecoder

What?  Perhaps we're talking at cross-prorposes here.  What I'm proposing
is that /proc/dmi should be a world-readable /proc file with the property
that 
	cat /proc/dmi

gives you a DMI report.  No root privileges or SUID programs needed.
Surely that would be an improvement on having to run Arjan's dmidecode as
root or requiring it to be SUID.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

No one who's seen it in action can say the phrase "government help" without
either laughing or crying.
