Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbUGZN7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUGZN7c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 09:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUGZN7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 09:59:31 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:57352 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S262873AbUGZN54 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 09:57:56 -0400
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Lenar =?utf-8?q?L=C3=B5hmus?= <lenar@vision.ee>
Subject: Re: 3C905 and ethtool
Date: Mon, 26 Jul 2004 15:57:54 +0200
User-Agent: KMail/1.6.2
References: <200407251016.22001.cijoml@volny.cz> <200407261000.34094.cijoml@volny.cz> <410507D0.3030305@vision.ee>
In-Reply-To: <410507D0.3030305@vision.ee>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407261557.54141.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne po 26. července 2004 15:32 jste napsal(a):
> Hi,
>
> Bc. Michal Semler wrote:
> >I tested it on few machines and it works for me on 8139too devices:
>
> Tested it on two machines:
>
> 3c59x:
> Settings for eth0:
> No data available

Hmm I receive in 3c59x:
# ethtool eth0
Cannot get device settings: Operation not supported

It looks like some kind of double bug?


>
> forcedeth:
> Settings for eth1:
>         Supports Wake-on: g
>         Wake-on: d
>         Link detected: yes
>
> tg3:
> Settings for eth0:
>         Supported ports: [ MII ]
>         Supported link modes:   10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Half 1000baseT/Full
>         Supports auto-negotiation: Yes
>         Advertised link modes:  10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Half 1000baseT/Full
>         Advertised auto-negotiation: Yes
>         Speed: 100Mb/s
>         Duplex: Full
>         Port: Twisted Pair
>         PHYAD: 1
>         Transceiver: internal
>         Auto-negotiation: on
>         Supports Wake-on: g
>         Wake-on: d
>         Current message level: 0x000000ff (255)
>         Link detected: yes
>
> 8139too:
> Settings for eth0:
>         Supported ports: [ TP MII ]
>         Supported link modes:   10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>         Supports auto-negotiation: Yes
>         Advertised link modes:  10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>         Advertised auto-negotiation: Yes
>         Speed: 100Mb/s
>         Duplex: Full
>         Port: MII
>         PHYAD: 32
>         Transceiver: internal
>         Auto-negotiation: on
>         Supports Wake-on: pumbg
>         Wake-on: d
>         Current message level: 0x00000007 (7)
>         Link detected: yes
>
> Lenar
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
