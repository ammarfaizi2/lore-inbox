Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUGZIAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUGZIAi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 04:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265022AbUGZIAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 04:00:38 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:51974 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S264991AbUGZIAg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 04:00:36 -0400
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: rpc@cafe4111.org
Subject: Re: 3C905 and ethtool
Date: Mon, 26 Jul 2004 10:00:34 +0200
User-Agent: KMail/1.6.2
References: <200407251016.22001.cijoml@volny.cz> <200407260218.29966.cijoml@volny.cz> <200407252127.37159.rpc@cafe4111.org>
In-Reply-To: <200407252127.37159.rpc@cafe4111.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407261000.34094.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested it on few machines and it works for me on 8139too devices:

# ethtool eth0
Settings for eth0:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 32
        Transceiver: internal
        Auto-negotiation: on
        Supports Wake-on: pumbg
        Wake-on: d
        Current message level: 0x00000007 (7)
        Link detected: yes

# ethtool eth0
Settings for eth0:

        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Supports auto-negotiation: Yes
        Speed: 10Mb/s
        Duplex: Half
        Port: MII
        PHYAD: 32
        Transceiver: internal
        Auto-negotiation: on
        Supports Wake-on: pumbg
        Wake-on: d

But this really doesn't work with 3c59x - probably it was destroyed somewhere 
in 2.4 - maybe 2.4.23, where were some ethtool fixes???

M.

Dne po 26. èervence 2004 03:27 Rob Couto napsal(a):
> This is weird. I'm able to try 4 machines: one has a RTL8139 card
> (8139too), two others are 1) Kingston and 2) generic cards (tulip), and the
> server uses 2x 3Com (3c59x) cards. and ethtool returns nothing, no data
> from any of them. What am I missing?
>
> "Curiouser and curiouser!"
