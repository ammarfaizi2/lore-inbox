Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267661AbUIUM6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267661AbUIUM6S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 08:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbUIUM6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 08:58:17 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:29915 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267696AbUIUM5g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 08:57:36 -0400
Date: Tue, 21 Sep 2004 13:58:08 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@localhost.localdomain
To: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: RARP support disapeard in kernel 2.6.x ?
In-Reply-To: <Pine.LNX.4.44.0409211354000.5322-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0409211357340.5322-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so, isn't rarpd (userspace daemon) supposed to provide what you want?
It is installed on most distributions by default I think...

Kind regards
Tigran

On Tue, 21 Sep 2004, Tigran Aivazian wrote:

> ah, you want a RARP server, not a client, sorry.
> I thought you wanted a RARP client.
> 
> Kind regards
> Tigran
> 
> On Tue, 21 Sep 2004, [ISO-8859-2] Tomasz K³oczko wrote:
> 
> > On Tue, 21 Sep 2004, Tigran Aivazian wrote:
> > 
> > > On Tue, 21 Sep 2004, [ISO-8859-2] Tomasz K³oczko wrote:
> > >> [linux-2.6.8.1]$ grep RARP .config
> > >
> > > Hmmm, you expected the above trivial command to reveal the answer?
> > > Besides, it assumes that you do have RARP configured in the kernel.
> > >
> > > Try this command instead:
> > >
> > > $ find -name Kconfig | xargs grep -i rarp
> > > ./net/ipv4/Kconfig:       supplied on the kernel command line or by BOOTP or RARP protocols.
> > > ./net/ipv4/Kconfig:config IP_PNP_RARP
> > > ./net/ipv4/Kconfig:     bool "IP: RARP support"
> > > ./net/ipv4/Kconfig:       discovered automatically at boot time using the RARP protocol (an
> > > ./net/ipv4/Kconfig:       here. Note that if you want to use RARP, a RARP server must be
> > > ./net/bridge/netfilter/Kconfig:   This option adds the ARP match, which allows ARP and RARP header fi
> > >
> > > The option you are looking for is CONFIG_IP_PNP_RARP.
> > 
> > No. Look on IP_PNP_RARP description.
> > I don't want boot using RARP/ARP but want prepare system where will be
> > possible setup RARP table for boot other system using ARP/RARP/TFTP.
> > 
> > kloczek
> > 
> 
> 

