Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144552AbRA1XZ3>; Sun, 28 Jan 2001 18:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144500AbRA1XZU>; Sun, 28 Jan 2001 18:25:20 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:9232 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S144509AbRA1XYn>; Sun, 28 Jan 2001 18:24:43 -0500
Date: Sun, 28 Jan 2001 18:23:58 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: John Jasen <jjasen@datafoundation.com>
Cc: Mike Pontillo <mike_p@polaris.wox.org>, linux-kernel@vger.kernel.org
Subject: Re: Support for 802.11 cards?
Message-ID: <20010128182358.F23716@alcove.wittsend.com>
Mail-Followup-To: John Jasen <jjasen@datafoundation.com>,
	Mike Pontillo <mike_p@polaris.wox.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101281344040.12805-100000@polaris.wox.org> <Pine.LNX.4.30.0101281704050.2343-100000@flash.datafoundation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <Pine.LNX.4.30.0101281704050.2343-100000@flash.datafoundation.com>; from jjasen@datafoundation.com on Sun, Jan 28, 2001 at 05:07:33PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 05:07:33PM -0500, John Jasen wrote:
> On Sun, 28 Jan 2001, Mike Pontillo wrote:

> > 	I was wondering what 802.11 PCI cards anyone knows of that run
> > under Linux-2.4. (or 2.2 for that matter)

> I _think_ a good many of the 802.11 wireless ISA and PCI cards are just
> bus to PCMCIA adapters, so it would be a question of whether or not the
> PCMCIA card is supported and if the bridge is supported.

	Last I knew (straight from the Lucent people), the ISA bridge
card worked fine and the PCI card did NOT work at all.  I've since
confirmed that, first hand, myself (I currently have the ISA bridge in
operation) on the 2.2 kernels.  The ISA bridge also works on the 2.4
kernels but I have not retested the PCI bridge on 2.4.  The Lucent
people claim that the Linux pcmcia people are aware of the problem.

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
