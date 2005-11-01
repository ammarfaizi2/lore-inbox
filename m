Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbVKAVu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVKAVu5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVKAVu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:50:57 -0500
Received: from mail.collax.com ([213.164.67.137]:11180 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751294AbVKAVuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:50:55 -0500
Message-ID: <4367E276.2040406@trash.net>
Date: Tue, 01 Nov 2005 22:47:34 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian McDonald <imcdnzl@gmail.com>
CC: Thomas Graf <tgraf@suug.ch>,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, bunk@stusta.de,
       jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PKT_SCHED]: Rework QoS and/or fair queueing configuration
References: <Pine.LNX.4.61.0510280902470.6910@yvahk01.tjqt.qr>	 <20051031102621.GF8009@stusta.de>	 <20051031132729.GK23537@postel.suug.ch>	 <20051101141302.GM23537@postel.suug.ch> <cbec11ac0511011154r13e7b695g@mail.gmail.com>
In-Reply-To: <cbec11ac0511011154r13e7b695g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian McDonald wrote:
> I keep meaning to submit a patch but low on my todo list. Feel free to
> do so if you wish or else I will get around to it one day. I know
> Arnaldo has also mentioned ktimers for the future (which I haven't yet
> read) which may help in this area as well.

AFAIK ktimers are another timer subsystem, but don't provide any
further clock sources. Having higher resolution timers would be
great however for improving accuracy when a qdisc is throttled.
