Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268171AbTAMUyE>; Mon, 13 Jan 2003 15:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268314AbTAMUyD>; Mon, 13 Jan 2003 15:54:03 -0500
Received: from mail2.bluewin.ch ([195.186.4.73]:194 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id <S268171AbTAMUyD>;
	Mon, 13 Jan 2003 15:54:03 -0500
Date: Mon, 13 Jan 2003 22:02:45 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Edward Tandi <ed@efix.biz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3-ac3 and KT400
Message-ID: <20030113210245.GB1327@k3.hellgate.ch>
Mail-Followup-To: Edward Tandi <ed@efix.biz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1042489183.2617.28.camel@wires.home.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042489183.2617.28.camel@wires.home.biz>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.57 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003 20:19:43 +0000, Edward Tandi wrote:
> I am running Linux on an ASUS A7V8X, VIA KT400 chipset motherboard. The
> [...]
> 4) Does anyone know whether I can get the ethernet interface to work
> using stock kernel net device drivers (yes VIA supply the source, but
> I'd rather use stock drivers)? I thought it was the via-rhine driver,
> but it doesn't seem to recognise the chip. Anyone got it working?

IIRC the KT400 comes with a VT8235 south bridge, so current stock kernel
should work (minus some bugs that still need fixing). What does lspci -vn
say? Anything in the kernel log when you try to load via-rhine?

Roger
