Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265102AbUGZNbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbUGZNbu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 09:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbUGZNbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 09:31:50 -0400
Received: from tristate.vision.ee ([194.204.30.144]:16845 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S265102AbUGZNbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 09:31:47 -0400
Message-ID: <410507D0.3030305@vision.ee>
Date: Mon, 26 Jul 2004 16:32:00 +0300
From: =?UTF-8?B?TGVuYXIgTMO1aG11cw==?= <lenar@vision.ee>
Organization: Vision
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cijoml@volny.cz
Cc: rpc@cafe4111.org, linux-kernel@vger.kernel.org
Subject: Re: 3C905 and ethtool
References: <200407251016.22001.cijoml@volny.cz> <200407260218.29966.cijoml@volny.cz> <200407252127.37159.rpc@cafe4111.org> <200407261000.34094.cijoml@volny.cz>
In-Reply-To: <200407261000.34094.cijoml@volny.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Bc. Michal Semler wrote:

>I tested it on few machines and it works for me on 8139too devices:
>  
>
Tested it on two machines:

3c59x:
Settings for eth0:
No data available

forcedeth:
Settings for eth1:
        Supports Wake-on: g
        Wake-on: d
        Link detected: yes

tg3:
Settings for eth0:
        Supported ports: [ MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: Twisted Pair
        PHYAD: 1
        Transceiver: internal
        Auto-negotiation: on
        Supports Wake-on: g
        Wake-on: d
        Current message level: 0x000000ff (255)
        Link detected: yes

8139too:
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

Lenar
