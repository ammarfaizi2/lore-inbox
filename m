Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUDXSbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUDXSbN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 14:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbUDXSbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 14:31:13 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:4112 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262450AbUDXSbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 14:31:12 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "SuD (Alex)" <sud@latinsud.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fealnx. Mac address and other issues
Date: Sat, 24 Apr 2004 21:30:38 +0300
User-Agent: KMail/1.5.4
References: <40885DCE.1090903@latinsud.com>
In-Reply-To: <40885DCE.1090903@latinsud.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404242130.38360.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 April 2004 03:05, SuD (Alex) wrote:
>...
> By the way, i get some Watchdog Timeouts while transmitting every 10
> minutes or so (also with 2.4 and original drivers).
> This is what i get:
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Transmit timed out, status 00000000, resetting...
>  Rx ring cf674000:  80000000 80000000 80000000 80000000 80000000
> 80000000 80000000 80000000 80000000 80000000 80000000 80000000
>  Tx ring cf675000:  80000000 80000000 80000000 80000000 80000000 0000

Hi Alex,

We were working on this recently.
Jeff Garzik just applied patches (to 2.6) which may fix timeout problem.

> I have also recently experienced problems with my cablemodem Motorola
> SB5100e. It has registered this mac address:
>     D4:62:00:02:44:1F
> which does not exist but is a mixture of my surecom card (fealnx)
> 00:02:44:1F:5F:59 and the network gateway 00:05:00:E2:D4:62.
> I am not sure who's fault this is (i would not trust my cablemodem much
> anyway).

Unfortunately, I do not have this hardware, but hope to
get it back from a friend soon. Will try to reproduce.

If I don't email you in a week, feel free to remind me.
--
vda

