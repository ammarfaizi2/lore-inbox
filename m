Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbVIFVS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbVIFVS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 17:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbVIFVS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 17:18:57 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:49854 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1750966AbVIFVS5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 17:18:57 -0400
Date: Tue, 6 Sep 2005 23:15:51 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Valdis.Kletnieks@vt.edu
Cc: Miroslaw Mieszczak <mieszcz@zabrze.zigzag.pl>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: Patch for link detection for R8169
Message-ID: <20050906211551.GC20862@electric-eye.fr.zoreil.com>
References: <431DA887.2010008@zabrze.zigzag.pl> <20050906194602.GA20862@electric-eye.fr.zoreil.com> <200509062002.j86K28R8019604@turing-police.cc.vt.edu> <20050906204221.GB20862@electric-eye.fr.zoreil.com> <200509062059.j86Kx17K022141@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509062059.j86Kx17K022141@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> :
> On Tue, 06 Sep 2005 22:42:21 +0200, Francois Romieu said:
> 
> > Currently one can do 'ifconfig ethX up', check the link status, then try
> > to DHCP or whatever. Apparently a few drivers do not support tne detection
> > of link as presented above. So is it anything like a vendor requirement/a
> > standard (or should it be the new right way (TM)) or does the userspace
> > needs fixing wrt its expectation ?
> 
> The "ifconfig up then check link status" method is probably usable for the
> vast majority of cases.  Are there any driver/card combos that *can't* be
> fixed to support that?  (A somewhat hidden side effect is that if you're

I meant "as presented above" == "check the link while the network device
is down".

--
Ueimor
