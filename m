Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbUCKTr6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbUCKTr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:47:57 -0500
Received: from eu81.neoplus.adsl.tpnet.pl ([83.30.2.81]:57224 "EHLO
	uran.kolkowski.no-ip.org") by vger.kernel.org with ESMTP
	id S261677AbUCKTry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:47:54 -0500
Date: Thu, 11 Mar 2004 20:47:14 +0100
From: Damian Kolkowski <damian@kolkowski.no-ip.org>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [i386] 2.6.4 + cdrtools-2.01a27 REPORT
Message-ID: <20040311194714.ALLYOURBASEAREBELONGTOUS.B25581@kolkowski.no-ip.org>
Mail-Followup-To: Kronos <kronos@kronoz.cjb.net>,
	linux-kernel@vger.kernel.org
References: <20040311162303.ALLYOURBASEAREBELONGTOUS.B29383@kolkowski.no-ip.org> <20040311175109.GA2467@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040311175109.GA2467@dreamland.darkstar.lan>
X-GPG-Key: 0xB2C5DE03 (http://kolkowski.no-ip.org/damian.asc x-hkp://wwwkeys.eu.pgp.net)
X-Girl: 1 will be enough!
X-Age: 24 (1980.09.27 - libra)
X-IM: JID:damian@kolkowski.no-ip.org ICQ:59367544 GG:88988
X-Operating-System: Slackware GNU/Linux, kernel 2.4.26-pre2-cset2, up 11:13
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kronos <kronos@kronoz.cjb.net> [2004-03-11 18:53]:
> >> I post this because I think it will maybe help some people that want to
> >> switch to a 2.6 and burn some CD quickly.
> > 
> > For me 2.6.x is useles, because freambuffer lack my radeon (rv25if),
> 
> Which driver are you using? This card should be supported by the new
> driver (and afaics also from the old one). If the new driver doesn't
> work for you can you send me a "lspci -nvvv" of your board?

Yep it's should but now in new version it's evil code :-)

Two drivers old and new one just won't listen to append i lilo.conf, even
fbset on old radeonfb mess with consle, demolish resolution to some unsuported
value.
New one is better, just use fbset -a -fb /dev/fb0 -depth 32 1024x768-100 and
you have one small screan i upper left corner off your screan ;-)
Bigger resolutions makes it smeller.

I was writing abaut new radeonfb to Ben, he knows about this. The mess with
old version starts since 2.6.4-rc2-cset103 (when I comple it on gentoo and
slackwe).

-- 
# Damian *dEiMoS* Ko³kowski # http://kolkowski.no-ip.org/ #
