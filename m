Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264802AbTFQPij (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 11:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264809AbTFQPij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 11:38:39 -0400
Received: from rth.ninka.net ([216.101.162.244]:60033 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264802AbTFQPi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 11:38:29 -0400
Subject: Re: Problems with PCMCIA/Orinoco
From: "David S. Miller" <davem@redhat.com>
To: bvermeul@blackstar.nl
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0306171159470.1854-100000@blackstar.nl>
References: <Pine.LNX.4.44.0306171159470.1854-100000@blackstar.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055865135.19796.2.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Jun 2003 08:52:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2003-06-17 at 03:01, bvermeul@blackstar.nl wrote:
> On Tue, 17 Jun 2003, Russell King wrote:
> 
> > On Tue, Jun 17, 2003 at 11:29:00AM +0200, bvermeul@blackstar.nl wrote:
> > > I'm having some problems with 2.5.71 (latest bk yesterday I believe).
> > > All works well (pcmcia works as advertised, with one tiny blip on
> > > the horizon), except when I want to reboot, when I get the following
> > > message:
> > > 
> > > unregister_netdevice: waiting for eth1 to become free. Usage count = 1
> > > 
> > > The net device is an Orinoco mini-pci card (eg, cardbus minipci interface 
> > > with built-in orinoco card), and it is down.
> > > 
> > > I'm not sure what causes this, and it's started somewhere in 2.5.70 bk.
> > 
> > I believe this is a netdevice problem and isn't anything to do with
> > PCMCIA or Cardbus.  If the net people would like to confirm this, it'd
> > be most helpful.
> 
> I'm also using a RTL8139 cardbus card, and that does not show this 
> particular problem (works great actually).
> So I'm not so sure it is a netdevice problem. It may be a orinoco
> problem, but I'm not entirely sure what's causing it.
> Just wanted to see if anyone's noticed it as well, and if a fix was
> out there.
> 
> Bas Vermeulen
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
David S. Miller <davem@redhat.com>
