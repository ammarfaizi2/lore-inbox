Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284966AbSADVAe>; Fri, 4 Jan 2002 16:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284933AbSADVAZ>; Fri, 4 Jan 2002 16:00:25 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:4242
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S284966AbSADVAI>; Fri, 4 Jan 2002 16:00:08 -0500
Date: Fri, 4 Jan 2002 15:44:13 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020104154413.E20097@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
	Lionel Bouton <Lionel.Bouton@free.fr>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020103133454.A17280@suse.cz> <Pine.GSO.3.96.1020104191141.829B-100000@delta.ds2.pg.gda.pl> <20020104200410.E21887@suse.cz> <20020104140538.A19746@thyrsus.com> <20020104202151.A22445@suse.cz> <20020104144146.A20097@thyrsus.com> <20020104212017.B22908@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020104212017.B22908@suse.cz>; from vojtech@suse.cz on Fri, Jan 04, 2002 at 09:20:17PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz>:
> I think I understand you. The problem is that many ISA chips (sound,
> others) that are normally used on ISA cards, and thus handled by drivers
> most likely labeled by the ISA_CARDS flag, can be, and were often
> integrated onto mainboards, even if those didn't have any ISA slots.
> 
> Think (possibly older generation, like P-MMX based) notebooks ... there
> you can have
> 
> X86 ... true
> PCI ... true
> DMI ... true
> DMI_ISA ... false
> BLACKLISTED ... possibly true, if you blacklist most notebooks
> 
> and yet have many ISA drivers needed for proper operation of the
> machine.

That would sure pump up the blacklist, all right.

I think at this point the right thing for me to do is gather data on the
scope of the problem.  I have some ideas about that.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

It is the assumption of this book that a work of art is a gift, not a
commodity.  Or, to state the modern case with more precision, that works of
art exist simultaneously in two "economies," a market economy and a gift
economy.  Only one of these is essential, however: a work of art can survive
without the market, but where there is no gift there is no art.
	-- Lewis Hyde, The Gift: Imagination and the Erotic Life of Property
