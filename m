Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268332AbTBYVY0>; Tue, 25 Feb 2003 16:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268333AbTBYVY0>; Tue, 25 Feb 2003 16:24:26 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:986 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id <S268332AbTBYVYY>;
	Tue, 25 Feb 2003 16:24:24 -0500
Date: Tue, 25 Feb 2003 22:34:38 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.20-usagi-grsec-pom
Message-ID: <Pine.LNX.4.51.0302252224130.1146@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i made a patch that applied over vanilla 2.4.20 adds:
- latest ip6 usagi stable
- latest grsecurity-1.9.9c
- all of the important pending netfilter patches (as up2date as pre4,
  forthcomming pre5)
- extra netfilter patches:
  HL-ipv6, IPV4OPTSSTRIP, NETLINK, NETMAP, REJECT-ipv6, SAME, TTL
  ahesp6-ipv6, frag-ipv6, fuzzy, hl-ipv6, iplimit, ipt_unclean-ubit,
  ipv4options, ipv6header-ipv6, mport, nth, pool, psd, quota, random
  realm, route6-ipv6, time, u32, CONNMARK, ROUTE, amanda-conntrack-nat
  condition, condition6, eggdrop-conntrack, h323-conntrack-nat,
  ip_tables-proc, ipt_TARPIT, mms-conntrack-nat, netfilter-docbook,
  nfnetlink-ctnetlink-0.11 pptp-conntrack-nat, quake3-conntrack, recent,
  rpc, rsh, string, talk-conntrack-nat, tftp-conntrack-nat

I guess some admins that want to make ipv4/ipv6 routers/firewalls +
hardened security from grsec, would like to get their hands on that.

http://dns.toxicfilms.tv/usagi_grsec_netfilter.diff.bz2

Regards,
Maciej Soltysiak

-----BEGIN GEEK CODE BLOCK-----
VERSION: 3.1
GIT/MU d-- s:- a-- C++ UL++++$ P L++++ E- W- N- K- w--- O! M- V- PS+ PE++
Y+ PGP- t+ 5-- X+ R tv- b DI+ D---- G e++>+++ h! y?
-----END GEEK CODE BLOCK-----
