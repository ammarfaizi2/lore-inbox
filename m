Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbTICHtN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 03:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbTICHtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 03:49:13 -0400
Received: from pa186.opole.sdi.tpnet.pl ([213.76.204.186]:38382 "EHLO
	uran.deimos.one.pl") by vger.kernel.org with ESMTP id S261596AbTICHtI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 03:49:08 -0400
Date: Wed, 3 Sep 2003 09:49:02 +0200
From: Damian Kolkowski <deimos@deimos.one.pl>
To: Danny ter Haar <dth@ncc1701.cistron.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4(-mmX) via-rhine ethernet onboard C3 mini-itx doesn't work
Message-ID: <20030903074902.GA1786@deimos.one.pl>
References: <bj447c$el6$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bj447c$el6$1@news.cistron.nl>
User-Agent: Mutt/1.4.1i
X-Age: 23 (1980.09.27 - libra)
X-Girl: one will be enough!
X-IM: JID:deimos@jid.deimos.one.pl ICQ:59367544 GG:88988
X-Operating-System: Slackware GNU/Linux, kernel 2.4.22-rc2-ac3, up 3 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 07:11:40AM +0000, Danny ter Haar wrote:
> vanilla 2.6.0-test4 & test4-mm[45] & the onboard ethernet doesn't seem to work.
> No kernel panics, it just doesn't work :-(

It's standard APIC bug that no one care!

> Both have same ethernet driver:
> 
> via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
>   http://www.scyld.com/network/via-rhine.html
> eth0: VIA VT6102 Rhine-II at 0xe800, 00:40:63:ca:6a:c1, IRQ 10.
> eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
> eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.

I have via_kt-400 on ecs_l7vta, just check my previous post:
#Message-ID: <20030902110335.GA540@deimos.one.pl>
#Subject: [BUG] - 2.{4,6}.{22,0-test4} - CONFIG_X86_UP_APIC lack routing on eth

> Even manual config (normal is dhcp) doesn't work.

Same to me.

> Haven't seen anyone else report this, but this is repeatable and i suspect
> more people must have experienced this ?!

I report this bug probably 4 times! And it was since early 2.4.20, then APIC
changes, so I can use if.

> Machine is running debian-unstable distro.

Slackware GNU/Linux (current).

P.S. I you wont to use eth with that kernel, silmpe uncompile
CONFIG_X86_UP_APIC and use APM.

PP.S. Maby you have ATI card? Bug with setfonts and loadkeys on 1 tty it's
from time to time :-)

-- 
# Damian *dEiMoS* Ko³kowski # http://deimos.one.pl/ #
