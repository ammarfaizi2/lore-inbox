Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130352AbQLaS4N>; Sun, 31 Dec 2000 13:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130376AbQLaS4D>; Sun, 31 Dec 2000 13:56:03 -0500
Received: from coruscant.franken.de ([193.174.159.226]:4875 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S130352AbQLaSzu>; Sun, 31 Dec 2000 13:55:50 -0500
Date: Sun, 31 Dec 2000 19:22:13 +0100
From: Harald Welte <laforge@gnumonks.org>
To: John Buswell <johnb@linuxcast.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: netfilter + 2.4.0-test10 causes connect:invalid argument
Message-ID: <20001231192213.C3307@coruscant.gnumonks.org>
In-Reply-To: <Pine.LNX.4.21.0012272311290.22827-100000@bloatfish.opaquenetworks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0012272311290.22827-100000@bloatfish.opaquenetworks.net>; from johnb@linuxcast.org on Wed, Dec 27, 2000 at 11:12:18PM -0500
X-Operating-System: 2.4.0-test11p4
X-Date: Today is Setting Orange, the 73rd day of The Aftermath in the YOLD 3166
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2000 at 11:12:18PM -0500, John Buswell wrote:
> 1. running 2.4.0-test10 with netfilter/iptables 1.1.2 ping/telnet gives
> you invalid argument when connecting to ports on local interfaces.

This is a _very_ strange problem. Nobody has erver reported this behaviour
to us (the netfilter developers).

I've never heared about it and never encountered it by myself. Sounds like 
it is a configuration issue.

could you please send me  the output of

lsmod
iptables -t filter -L -v -n
iptables -t nat -L -v -n
iptables -t mangle -L -v -n


btw: the netfilter mailinglist is probably the more apropriate place
for discussion of netfilter related stuff. See http://netfilter.samba.org
for subscription instructions.

> John Buswell 

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
