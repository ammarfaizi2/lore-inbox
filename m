Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288914AbSA3INy>; Wed, 30 Jan 2002 03:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288956AbSA3IMo>; Wed, 30 Jan 2002 03:12:44 -0500
Received: from coruscant.franken.de ([193.174.159.226]:38290 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S288971AbSA3ILn>; Wed, 30 Jan 2002 03:11:43 -0500
Date: Wed, 30 Jan 2002 09:06:40 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Malcolm Mallardi <magamo@ranka.2y.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Netfilter(MASQ) and PPPoE problem? (2.4.17)
Message-ID: <20020130090640.T26676@sunbeam.de.gnumonks.org>
In-Reply-To: <20020130015040.A19998@trianna.upcommand.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020130015040.A19998@trianna.upcommand.net>; from magamo@ranka.2y.net on Wed, Jan 30, 2002 at 01:50:40AM -0500
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Pungenday, the 28th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 01:50:40AM -0500, Malcolm Mallardi wrote:
> 	Heyla, folks.  I've got an interesting little report for y'all,
> was hoping to get a bit more insight, 'cause I'm rather stumped on it,
> and can't really make heads or tails of it.  I've got a DSL with PPPoE
> set up on the router (running 2.4.17, with NAT) and seem to be having
> problems getting to web sites from client machines behind the firewall.

Have you tried the TCPMSS target in the mangle chain in order to clamp
the TCP MSS to the mtu?

This seems to be the problem you are encountering.

For further questions please follow up to the netfilter users mailing list
at netfilter@lists.samba.org.

> Malcolm D. Mallardi - Dark Freak At Large

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
