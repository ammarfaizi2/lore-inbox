Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268753AbUIQNjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268753AbUIQNjx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268756AbUIQNjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:39:53 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:7394 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S268753AbUIQNjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:39:40 -0400
Date: Fri, 17 Sep 2004 15:38:09 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Lincoln Dale <ltd@cisco.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, paul@clubi.ie,
       netdev@oss.sgi.com, leonid.grossman@s2io.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The ultimate TOE design
Message-ID: <20040917133809.GD28745@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org> <1095275660.20569.0.camel@localhost.localdomain> <4148A90F.80003@pobox.com> <20040915140123.14185ede.davem@davemloft.net> <20040915210818.GA22649@havoc.gtf.org> <20040915141346.5c5e5377.davem@davemloft.net> <5.1.0.14.2.20040916192213.04240008@171.71.163.14> <1095337159.22739.7.camel@localhost.localdomain> <20040916133301.GA15562@wotan.suse.de> <5.1.0.14.2.20040917083305.04f4d008@171.71.163.14>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5.1.0.14.2.20040917083305.04f4d008@171.71.163.14>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 September 2004 08:37:17 +1000, Lincoln Dale wrote:
> 
> sure -- ok -- that gets you the main processor.
> now add to that a Northbridge (perhaps AMD doesnt need that but i'm sure it 
> still does), Southbridge, DDR-SDRAM, ancilliary chips for doing MAC, PHY, 
> ...
> 
> couple that with the voltage of PCI where you're likely to need 
> step-up/step-down circuits (which aren't 100% efficient themselves), you're 
> still going to get very close to the limit, if not over it.
> 
> ... and after all that, the Geode is really designed to be an embedded 
> processor.
> Jeff was implying using garden-variety processors which seem to have large 
> heatsinks, not to mention cooling fans, not to mention quite significant 
> heat generation.
> 
> we're not _quite_ at the stage of being able to take garden-variety 
> processors and build-your-own-blade-server using PCI _just_ yet. :-)

FWIW, I've already been working with complete systems that suck their
power from PCI.  They do exist, just not in the grocery store next
door.

Jörn

-- 
Das Aufregende am Schreiben ist es, eine Ordnung zu schaffen, wo
vorher keine existiert hat.
-- Doris Lessing
