Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271462AbTGQObB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 10:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271463AbTGQObB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 10:31:01 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:12198 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S271462AbTGQObA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 10:31:00 -0400
Date: Thu, 17 Jul 2003 16:45:49 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1-ac2 issues / Toshiba Laptop keyboard
Message-ID: <20030717144549.GL7864@charite.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030717141847.GF7864@charite.de> <1058452714.9048.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058452714.9048.4.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk>:

> > * eepro100 is b0rked:
> > 
> > eepro100: Unknown symbol mii_ethtool_sset
> > eepro100: Unknown symbol mii_link_ok
> > eepro100: Unknown symbol mii_check_link
> > eepro100: Unknown symbol mii_nway_restart
> > eepro100: Unknown symbol mii_ethtool_gset
> 
> You must load mii as well. The module tools should be doing that if
> you are using modprobe

I see.

> > * The IDE ATA disk works, but upon reboot, the machine does NOT find
> >   the IDE harddisk anymore! Tis means I have to turn the machine off
> >   and on again (since it has no reset button)
> 
> Curious. Could be the BIOS doesn't know how to do hard disk power
> management especially if its quite an old PC 

It's last year's model. Not quite old I'd say.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
