Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289044AbSANUyW>; Mon, 14 Jan 2002 15:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289025AbSANUyQ>; Mon, 14 Jan 2002 15:54:16 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:49030
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289043AbSANUyE>; Mon, 14 Jan 2002 15:54:04 -0500
Date: Mon, 14 Jan 2002 15:38:44 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020114153844.A20537@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020114132618.G14747@thyrsus.com> <m16QCNJ-000OVeC@amadeus.home.nl> <20020114145035.E17522@thyrsus.com> <20020114213732.M15139@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020114213732.M15139@suse.de>; from davej@suse.de on Mon, Jan 14, 2002 at 09:37:32PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de>:
> On Mon, Jan 14, 2002 at 02:50:35PM -0500, Eric S. Raymond wrote:
>  > "Crap." Melvin thinks.  "I don't remember what kind of network card I
>  > compiled in.  Am I going to have to open this puppy up just to eyeball
>  > the hardware?" Doing that would take time Melvin was planning to spend
>  > chatting up a girl geek he's noticed over at the computer lab.
>  > Autoconfigure saves the day.  Possibly it even helps Melvin get laid.
> 
>  Unless of course, geekgirl realises what a dork Melvin was for
>  not doing something like lsmod / looking in /var/log/messages for
>  boot messages showing not only what card he has, but what driver
>  he needs.

Right now, neither lsmod nor the boot time messages  necessarily give you that 
information.  lsmod only works if the driver is in fact a module.  My 
/var/log/dmesg contains no message from the NIC on my motherboard.  And
going from the driver to the config symbol isn't trivial even if you *have*
the lsmod or dmesg information.  

And anyway there are settings you can't even recover by looking at the
hardware, such as whether KHTTPD or BSD process accounting were turned
on.

Sure, Melvin could remember a whole bunch of state, or a whole bunch
of rules for reconstructing it. But isn't sweating that kind of detail
exactly what *computers* are for?  

Melvin, you may be sure, has more important things on his mind...
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

That the said Constitution shall never be construed to authorize
Congress to infringe the just liberty of the press or the rights of
conscience; or to prevent the people of the United states who are
peaceable citizens from keeping their own arms...
        -- Samuel Adams, in "Phila. Independent Gazetteer", August 20, 1789
