Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129774AbRB1LAb>; Wed, 28 Feb 2001 06:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129828AbRB1LAW>; Wed, 28 Feb 2001 06:00:22 -0500
Received: from blackhole.adamant.net ([212.26.128.69]:59688 "EHLO
	blackhole.adamant.net") by vger.kernel.org with ESMTP
	id <S129774AbRB1LAN>; Wed, 28 Feb 2001 06:00:13 -0500
Date: Wed, 28 Feb 2001 13:00:02 +0200
From: Alexander Trotsai <mage@adamant.net>
To: linux-kernel@vger.kernel.org
Subject: strage locks with netfilter in 2.4.2 and 2.4.2ac6
Message-ID: <20010228130002.A28606@blackhole.adamant.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
Organization: Adamant ISP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I try to upgrade one of my servers with 2.4.2 and than 2.4.2ac6
and got strage locks when I start my netfilter firewall

Strange I have that this script work ok on my individual PC
I copy this script to server, change opened ports and start it

In this script I you connection track, flags checks, limit module and
standart tcp/udp acception and rejection

When I remove any tracks and flag check PC seems to work ok (in
firewall I make only simple check tcp/udp ports with acception and
limit in logging nothing else)

And I can't understand why this script work ok on my PC but wan't work
at this server.

Defference in kernel configuration I can found:
- no ip forward on server
- no advanced routing on server
- and no alternative queue on server

____________________________________________________________________
Info&Contacts -- RIPE: MAGE-RIPE, InterNic: AT2963, ICQ: 18035130
PGP: ftp://blackhole.adamant.net/pgp/mykey.pgp.asc

