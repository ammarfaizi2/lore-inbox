Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131503AbRCWXJg>; Fri, 23 Mar 2001 18:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131506AbRCWXJ0>; Fri, 23 Mar 2001 18:09:26 -0500
Received: from fenrus.demon.co.uk ([158.152.228.152]:62079 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S131503AbRCWXJJ>;
	Fri, 23 Mar 2001 18:09:09 -0500
Date: Fri, 23 Mar 2001 22:56:51 +0000
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Andrew Morton <morton@nortelnetworks.com>
Cc: Lawrence Walton <lawrence@the-penguin.otak.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2-ac21
Message-ID: <20010323225651.A20586@fenrus.demon.nl>
In-Reply-To: <20010322162802.A909@the-penguin.otak.com> <3ABAA2E6.9D40B7B6@asiapacificm01.nt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ABAA2E6.9D40B7B6@asiapacificm01.nt.com>; from morton@nortelnetworks.com on Fri, Mar 23, 2001 at 01:12:06AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2001 at 01:12:06AM +0000, Andrew Morton wrote:
> Lawrence Walton wrote:
> > 
> > Hello all
> > 2.4.2-ac21 seems to have a couple problems.
> > ...
> > 
> > Mar 22 15:15:55 the-penguin kernel: NETDEV WATCHDOG: eth0: transmit timed out
> > ...
> > 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
> 
> People have recently been changing VIA PCI bridge settings
> to try to fix the file corruption thing.  There has been one
> report that this change causes a 3c905C to go silly.
> 
> This looks like the same problem to me.

Could very well be. The problem is that your VIA chipset (or rather the
chipset as used on at least some of the boards out there) will corrupt your
data if this setting is not done.....

Greetings,
   Arjan van de Ven
