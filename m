Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284302AbSABV3O>; Wed, 2 Jan 2002 16:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284795AbSABV3A>; Wed, 2 Jan 2002 16:29:00 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:41859
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S284304AbSABV1M>; Wed, 2 Jan 2002 16:27:12 -0500
Date: Wed, 2 Jan 2002 16:13:47 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102161347.A16223@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16LsU0-0005RB-00@the-village.bc.nu> <Pine.LNX.4.33.0201022200070.427-100000@Appserv.suse.de> <20020102162349.A957@apone.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020102162349.A957@apone.devel.redhat.com>; from notting@redhat.com on Wed, Jan 02, 2002 at 04:23:49PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Nottingham <notting@redhat.com>:
> Dave Jones (davej@suse.de) said: 
> > > You can make an educated guess. However it is at best an educated guess.
> > > The DMI tables will tell you what PCI and ISA slots are present (but
> > > tend to be unreliable on older boxes).
> > 
> > And newer ones. I've seen 'Full length ISA slot' reported on a laptop
> > for eg.
> 
> I have an ia64 here that, according to dmidecode, has a
> 32bit NUBUS slot in it. AFAIK, that's not the case. ;)

I just downloaded and tested Arjan deVen's dmidecode.c program.
That will do what I want, but it has the irritating problem that
it requires root privileges for access to /dev/kmem.

Is the DMI data available in /proc files anywhere?

If not, should it be?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Taking my gun away because I might shoot someone is like cutting my tongue
out because I might yell `Fire!' in a crowded theater."
        -- Peter Venetoklis
