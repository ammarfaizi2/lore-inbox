Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262715AbRGIQRO>; Mon, 9 Jul 2001 12:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262682AbRGIQQz>; Mon, 9 Jul 2001 12:16:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:9997 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262568AbRGIQQs>; Mon, 9 Jul 2001 12:16:48 -0400
Date: Mon, 9 Jul 2001 09:18:59 -0700 (PDT)
From: Patrick Mochel <mochel@transmeta.com>
To: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        saw@saw.sw.com.sg
Subject: Re: 2.4.6.-ac2: Problems with eepro100
In-Reply-To: <3B498B54.84B76534@TeraPort.de>
Message-ID: <Pine.LNX.4.10.10107090841550.1391-100000@nobelium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>  additional datapoint: if I use "eepro100.c" from vanilla 2.4.6, the
> interface works OK. So, maybe the problems are power-managment related,
> as the eepro100 differences in -ac2 seem to concern that area.

That is most likely power management related; it sounds like the device
is not in the state it's supposed to be. 

Can you do an 'lspci -vv' on the device? The current device state should
be listed 2 lines after the Power Management Capabilities revision.

	-pat

