Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135969AbRDTQlH>; Fri, 20 Apr 2001 12:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135971AbRDTQk5>; Fri, 20 Apr 2001 12:40:57 -0400
Received: from coruscant.franken.de ([193.174.159.226]:46096 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S135966AbRDTQkn>; Fri, 20 Apr 2001 12:40:43 -0400
Date: Fri, 20 Apr 2001 13:17:19 -0300
From: Harald Welte <laforge@gnumonks.org>
To: hps@intermeta.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: IP Acounting Idea for 2.5
Message-ID: <20010420131719.A2461@tatooine.laforge.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33.0104152039130.1616-100000@asdf.capslock.lan> <01041708461209.00352@workshop> <20010416020732.30431.qmail@logi.cc> <20010416224321.O16697@corellia.laforge.distro.conectiva> <9bgpfa$329$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <9bgpfa$329$1@forge.intermeta.de>; from mailgate@mail.hometree.net on Tue, Apr 17, 2001 at 06:56:42AM +0000
X-Operating-System: Linux tatooine.laforge.distro.conectiva 2.4.2-ac20
X-Date: Today is Setting Orange, the 37th day of Discord in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 06:56:42AM +0000, Henning P. Schmiedehausen wrote:
> 
> Resettable counters in a security sensitive environment are just a
> call for trouble. That's why you can't reset the SNMP counters on any
> Cisco device I've encountered today. They learned their lesson. Maybe
> you will, too.

Well, I'm not sure about which SNTP counters you are talking, but I suppose
it is not about per-filtering-rule counters, but something like per-interface
counters, etc.

There's always a way for somebody with root access to reset the counters of
a rule: 

just delete and re-insert the rule.

If somebody wants to reset the counter, he can. If we remove the functionality
from iptables, people still can - but it's more difficult.

> 	Regards
> 		Henning

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
