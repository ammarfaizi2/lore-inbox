Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267876AbTAMRPt>; Mon, 13 Jan 2003 12:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267907AbTAMRPt>; Mon, 13 Jan 2003 12:15:49 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:12261 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267876AbTAMRPr>;
	Mon, 13 Jan 2003 12:15:47 -0500
Date: Mon, 13 Jan 2003 09:24:35 -0800
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.4.20-pre11: PCI Wavelan card loses connection
Message-ID: <20030113172435.GC20409@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <200301130821.h0D8Kis26772@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301130821.h0D8Kis26772@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 10:20:14AM +0200, Denis Vlasenko wrote:
> I bought a PCI wireless card, a DLink-520 (I think, I forgot exactly
> (it's at home), anyway, lspci dump is below).
> 
> We (my father and me) made a fairly long helical aerial.
> We are trying to communicate over ~15 km with a small wireless cell.
> (~10 hosts, one AP).
> 
> We can successfully associate with it, signal is weak as expected.
> But after a short while our eth0 seems to 'fall off the net'
> and while it looks like we can send packets, we see no incoming data
> at all.
> 
> Since I have almost zero wireless experience, I'll be happy if someone
> with said experience can read further and say what bites us.

	Personally, I never managed to get this hardware to work at
all. And Orinoco is known to have problems with PrismII cards. Please
use the HostAP or linux-wlan-ng driver.
	Good luck...

	Jean
