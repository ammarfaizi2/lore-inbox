Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268070AbUIPNeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268070AbUIPNeK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 09:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268065AbUIPNeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 09:34:09 -0400
Received: from cantor.suse.de ([195.135.220.2]:29361 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268074AbUIPNdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 09:33:09 -0400
Date: Thu, 16 Sep 2004 15:33:01 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lincoln Dale <ltd@cisco.com>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, paul@clubi.ie,
       netdev@oss.sgi.com, leonid.grossman@s2io.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The ultimate TOE design
Message-ID: <20040916133301.GA15562@wotan.suse.de>
References: <20040915141346.5c5e5377.davem@davemloft.net> <4148991B.9050200@pobox.com> <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org> <1095275660.20569.0.camel@localhost.localdomain> <4148A90F.80003@pobox.com> <20040915140123.14185ede.davem@davemloft.net> <20040915210818.GA22649@havoc.gtf.org> <20040915141346.5c5e5377.davem@davemloft.net> <5.1.0.14.2.20040916192213.04240008@171.71.163.14> <1095337159.22739.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095337159.22739.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 01:19:21PM +0100, Alan Cox wrote:
> On Iau, 2004-09-16 at 10:29, Lincoln Dale wrote:
> > . . . this ignore the realities of power restrictions of PCI today . . .
> > sure, one could create a PCI card that takes a power-connector, but that 
> > don't scale so well either . . .
> 
> At 1Ghz the Athlon Geode NX draws about 6W. Thats less than my SCSI

Are you sure that's worst case, not average? Worst case is usually
much worse on a big CPU like an Athlon, but the power supply 
has to be sized for it. 

-Andi
