Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287149AbSBYUEq>; Mon, 25 Feb 2002 15:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286179AbSBYUEZ>; Mon, 25 Feb 2002 15:04:25 -0500
Received: from zamok.crans.org ([138.231.136.6]:40630 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S293219AbSBYUDj>;
	Mon, 25 Feb 2002 15:03:39 -0500
To: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: static arp table doesn't size up ?
In-Reply-To: <m34rk5suyk.fsf@neo.loria>
	<20020225204238.A10218@ragnar-hojland.com>
X-PGP-KeyID: 0xF22A794E
X-PGP-Fingerprint: 5854 AF2B 65B2 0E96 2161  E32B 285B D7A1 F22A 794E
From: Vincent Bernat <bernat@free.fr>
In-Reply-To: <20020225204238.A10218@ragnar-hojland.com> (Ragnar Hojland
 Espinosa's message of "Mon, 25 Feb 2002 20:42:38 +0100")
Organization: Kabale Inc
Date: Mon, 25 Feb 2002 21:03:37 +0100
Message-ID: <m3pu2tnxba.fsf@neo.loria>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Common Lisp,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OoO Pendant le journal télévisé du lundi 25 février 2002, vers 20:42,
Ragnar Hojland Espinosa <ragnar@jazzfree.com> disait:

> You may want to try to increment the thresholds for garbage collection in
> net/ipv4/arp.c or play with the userland arpd in case the kernel is having
> problem allocating as many ARP entries as you are using.

Thanks, however, I am still under the 1024 limit and since there is no
learning, there is no need of garbage collection. However, I will try
to modify the thresholds (they can be modified via /proc/net/arp).
