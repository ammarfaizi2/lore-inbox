Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbTFTJRn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 05:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbTFTJRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 05:17:43 -0400
Received: from 211.187-201-80.adsl.skynet.be ([80.201.187.211]:57868 "EHLO
	obelix.village-gaulois") by vger.kernel.org with ESMTP
	id S262547AbTFTJRj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 05:17:39 -0400
Subject: Re: xircom card bus with 2.4.21 link trouble (was: xircom card bus
	with 2.4.20 link trouble)
From: Arnaud Ligot <spyroux@freegates.be>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1056101193.6728.14.camel@portable>
References: <1056101193.6728.14.camel@portable>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1056101484.6724.18.camel@portable>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 20 Jun 2003 11:31:25 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/me auto slaps 

with the 2.4.20, it work but it don't work with 2.4.21.
Sorry

Le ven 20/06/2003 à 11:26, Arnaud Ligot a écrit :
> Hello,
> 
> Since I run the 2.4.21 kernel (+bootsplash patch), (I didn't try without
> this patch but I think it is not the problem), my Xircom Cardbus don't
> work any more! In fact, I put the card into the pcmcia slot, the pc
> detect it, load the correct module (xirc2ps_cb), start eth1 but the led
> link (both side) blinks.
> I have try with a hub 10, a ethernet card 10 and an ethernet card
> 10/100. I have so try 2 cables... but same problem.
> I have try to impose the ethernet type of link mii-tool -A10BaseT-HD and
> -F10BaseT-HD.
> 
> Thanks
> 
> Arnaud
> 
> extract of /var/messages (10mbps):
> ------
> Jun 20 08:34:49 portable kernel: cs: memory probe 0xa0000000-0xa0ffffff:
> clean.
> Jun 20 08:34:49 portable kernel: xirc2ps_cs.c 1.31 1998/12/09 19:32:55
> (dd9jn+kvh)
> Jun 20 08:34:53 portable kernel: eth1: autonegotiation failed; using
> 10mbs
> Jun 20 08:34:53 portable kernel: eth1: MII selected
> Jun 20 08:34:53 portable kernel: eth1: media 10BaseT, silicon revision 0
> Jun 20 08:34:53 portable kernel: eth1: Xircom: port 0x300, irq 3, hwaddr
> 00:80:C7:CC:1F:A
> 2
> Jun 20 08:34:54 portable kernel: eth1: autonegotiation failed; using
> 10mbs
> Jun 20 08:34:54 portable kernel: eth1: MII selected
> Jun 20 08:34:54 portable kernel: eth1: media 10BaseT, silicon revision 0
> Jun 20 08:34:59 portable kernel: eth1: autonegotiation failed; using
> 10mbs
> Jun 20 08:34:59 portable kernel: eth1: MII selected
> ....
> -----
> 
> short extract of /var/messages (100mbps):
> -----
> Jun 20 10:14:52 portable kernel: eth1: MII link partner: 05e1
> Jun 20 10:14:52 portable kernel: eth1: MII selected
> Jun 20 10:14:52 portable kernel: eth1: media 100BaseT, silicon revision
> 5
> -----
> 
> ----
-- 
Arnaud Ligot <spyroux@freegates.be>

