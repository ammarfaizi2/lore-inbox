Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284809AbSADUUc>; Fri, 4 Jan 2002 15:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284755AbSADUUX>; Fri, 4 Jan 2002 15:20:23 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:10383 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S284728AbSADUUJ>;
	Fri, 4 Jan 2002 15:20:09 -0500
Date: Fri, 4 Jan 2002 21:19:31 +0100
From: David Weinehall <tao@acc.umu.se>
To: "Eric S. Raymond" <esr@thyrsus.com>, Vojtech Pavlik <vojtech@suse.cz>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020104211931.D5235@khan.acc.umu.se>
In-Reply-To: <20020103133454.A17280@suse.cz> <Pine.GSO.3.96.1020104191141.829B-100000@delta.ds2.pg.gda.pl> <20020104200410.E21887@suse.cz> <20020104140538.A19746@thyrsus.com> <20020104202151.A22445@suse.cz> <20020104144146.A20097@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20020104144146.A20097@thyrsus.com>; from esr@thyrsus.com on Fri, Jan 04, 2002 at 02:41:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 02:41:46PM -0500, Eric S. Raymond wrote:

[snip]

> This is one reason I want /sys/dmi -- because if I *don't* see it, that
> means I should assume the machine is old enough to take ISA cards.  This
> filter should make the blacklist relatively small -- we wouldn't have to
> track even PCI motherboards older than the DMI standard.

If you find an MCA-bus, you can suppress most (but not all) ISA-cards
too (some of the cards support MCA without having any extra MCA-related
code in the drivers, such as the eexpress-driver, but I can help with
such a list if necessary.)


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
