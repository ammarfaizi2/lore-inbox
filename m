Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289952AbSAPOe0>; Wed, 16 Jan 2002 09:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290395AbSAPOeR>; Wed, 16 Jan 2002 09:34:17 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:6828 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S289952AbSAPOeK>;
	Wed, 16 Jan 2002 09:34:10 -0500
Date: Wed, 16 Jan 2002 14:33:28 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Rob Landley <landley@trommello.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Larry McVoy <lm@bitmover.com>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@thyrsus.com>, Eli Carter <eli.carter@inet.com>,
        "Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery --
 the elegant solution)
Message-ID: <83880343.1011191608@[10.132.113.67]>
In-Reply-To: <20020116074700.IUTL28557.femail14.sdc1.sfba.home.com@there>
In-Reply-To: <20020116074700.IUTL28557.femail14.sdc1.sfba.home.com@there>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

>> Example: put in some wget based thingy, which goes to some (fixed) web
>> site, searches for (some extracted or Tillie composed string) which
>> describes the hardware (bound to have been bought as-is and never
>> opened), pulls down a set of config files and heuristics to determine
>> between them (look at BIOS, or 'that model will always show this or that
>> in the PCI table') and guesses the correct (initial) config as tested by
>> some other user.
>
> Meaning you'll continue to be six months behind the curve, and fail every
> time Dell tweaks its laptop layout.  (Dell does things like switch sound
> chips without switching model numbers ALL THE TIME.)
>
> Are you volunteering to maintain this database?

No, noone 'maintains' it; I actually /meant/ search.
So if you run it on a Redhat distribution, it goes queries
redhat first, then lists
  IBM T23 - Alex Bligh
  IBM T23 new version - Rob Landley
...
etc.

IE is the minimum amount of automation to simulate typing the thing
into google. (the advantage of doing this over using google
alone is that X may not be working at this stage and lynx
might daunt Aunt Tillie).

Obviously you will need some magic tag at the top of a config
file to make it easilly identifiable to search engines. And no
doubt some fools will fill files with crap.

> So no-name assembled white boxes from e-machines and stuff wouldn't be
> supported?

Correct; I'm sure the probing configurator has a place too.

> Have you TRIED the current auto-configurator?

No, to be honest. However, now you have set me the challenge, I'll
report back on how well or otherwise it works.

> Assuming every IBM T23 has the same hardware in it, which oddly enough is
> a  bit of a gamble.  (OK, IBM is better at this than Dell, largely due to
> inventory management reasons.)  And assuming the finite number of
> database  maintainers has yet bought an IBM T23, and that the rest of the
> world can  wait until then.

Well, you'd wait until either your distro vendor had done one, or
someone else had posted one and it had reached search-engine
du-jour.

> Requiring live network access for the autoconfigurator to work is one
> heck of  an extra requirement, though.  Most of the world is still using
> dialup, you  know...

True.

>> And Aunt Tillie (apart from the module changes whatever)
>> can be using the kernel version etc. from their distro (recompiled),
>> rather than the latest 2.[2468].xx with lots of new bugs^Wunwanted
>> fixes in.
>
> You want to write some other tool.

Perhaps you are right.

> Giacamo and Eric started work on the autoprobe as a way to reduce the
> number  of questions the configurator showed people by eliminating
> hardware that they  provably do not have, and defaulting the stuff they
> DO have to on.  But it  turns out that on any relatively recent machine,
> it's an easy enough problem  that you can autoprobe EVERYTHING and build
> straight from that.  So the Linux  kernel could finally do "configure;
> make; make install".
>
> I consider that a neat hack.

Sure I agree, if it works; my speculation is that it doesn't, if one
boots with a default vendor kernel, on many machines. I would love
to be proved wrong, so rather than debate further here, I have another
T23 to set up so I'll boot it up from scratch, run the configurator,
and see what happens.

--
Alex Bligh
