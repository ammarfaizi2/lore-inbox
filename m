Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264262AbUD0SeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbUD0SeS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 14:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264269AbUD0SeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 14:34:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9948 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264262AbUD0SeL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 14:34:11 -0400
Date: Tue, 27 Apr 2004 19:34:10 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?
Message-ID: <20040427183410.GZ17014@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0404270034110.4469@alpha.polcom.net> <20040426225620.GP17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404270157160.6900@alpha.polcom.net> <20040427002323.GW17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404261758230.19703@ppc970.osdl.org> <20040427010748.GY17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404271106500.22815@alpha.polcom.net> <1083070293.30344.116.camel@watt.suse.com> <Pine.LNX.4.58.0404271500210.27538@alpha.polcom.net> <20040427140533.GI14129@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427140533.GI14129@stingr.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 06:05:34PM +0400, Paul P Komkoff Jr wrote:
> Replying to Grzegorz Kulewski:
> > But it is strange that I need kernel patch even if I have no evms 
> > or dm volumes in my system. Can not it be solved in mainstream kernels?
> > Maybe there should be warning in config help temporaily? Maybe even note 
> > after option name?
> 
> This defect grew up off a disagreement between bdclaim authors and
> evms authors

Excuse me?  The damn thing had found nothing.  However, it didn't care
to release the devices it had claimed - hadn't even closed them, as the
matter of fact.  That's a clear and obvious bug, regardless of any
disagreements.

Speaking of the proposed "solutions", how about #4: figure out what,
when and for how long do they really want to claim and take care to
release what they don't end up using?

WTF is going on there?
