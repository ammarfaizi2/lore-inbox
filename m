Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267649AbUIUMwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267649AbUIUMwW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 08:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUIUMwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 08:52:22 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:29201 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S267649AbUIUMwT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 08:52:19 -0400
Date: Tue, 21 Sep 2004 14:52:22 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: RARP support disapeard in kernel 2.6.x ?
In-Reply-To: <Pine.LNX.4.44.0409211342280.5322-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.60L.0409211446590.15099@rudy.mif.pg.gda.pl>
References: <Pine.LNX.4.44.0409211342280.5322-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-700957773-1095771142=:15099"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-700957773-1095771142=:15099
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 21 Sep 2004, Tigran Aivazian wrote:

> On Tue, 21 Sep 2004, [ISO-8859-2] Tomasz K³oczko wrote:
>> [linux-2.6.8.1]$ grep RARP .config
>
> Hmmm, you expected the above trivial command to reveal the answer?
> Besides, it assumes that you do have RARP configured in the kernel.
>
> Try this command instead:
>
> $ find -name Kconfig | xargs grep -i rarp
> ./net/ipv4/Kconfig:       supplied on the kernel command line or by BOOTP or RARP protocols.
> ./net/ipv4/Kconfig:config IP_PNP_RARP
> ./net/ipv4/Kconfig:     bool "IP: RARP support"
> ./net/ipv4/Kconfig:       discovered automatically at boot time using the RARP protocol (an
> ./net/ipv4/Kconfig:       here. Note that if you want to use RARP, a RARP server must be
> ./net/bridge/netfilter/Kconfig:   This option adds the ARP match, which allows ARP and RARP header fi
>
> The option you are looking for is CONFIG_IP_PNP_RARP.

No. Look on IP_PNP_RARP description.
I don't want boot using RARP/ARP but want prepare system where will be
possible setup RARP table for boot other system using ARP/RARP/TFTP.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--8323328-700957773-1095771142=:15099--
