Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130153AbRAXMn3>; Wed, 24 Jan 2001 07:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131977AbRAXMnT>; Wed, 24 Jan 2001 07:43:19 -0500
Received: from coruscant.franken.de ([193.174.159.226]:519 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S131965AbRAXMm7>; Wed, 24 Jan 2001 07:42:59 -0500
Date: Wed, 24 Jan 2001 13:41:42 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and ipmasq modules
Message-ID: <20010124134142.Y6055@coruscant.gnumonks.org>
In-Reply-To: <20010120144616.A16843@vitelus.com> <E14KsZI-0006IU-00@halfway> <20010122180158.B24670@vitelus.com> <E14Kxtc-0000KT-00@kabuki.eyep.net> <20010123085633.D32100@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010123085633.D32100@vitelus.com>; from aaronl@vitelus.com on Tue, Jan 23, 2001 at 08:56:33AM -0800
X-Operating-System: 2.4.0-test11p4
X-Date: Today is Pungenday, the 13rd day of Chaos in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2001 at 08:56:33AM -0800, Aaron Lehmann wrote:
> On Tue, Jan 23, 2001 at 06:29:34PM +1100, Daniel Stone wrote:
> > Well, it's NAT'ing it OK. Are you sure you have a rule like the
> > following:
> > iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
> > ?
> # iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
> iptables: No chain/target/match by that name

please move this discussion to the netfilter mailinglist.

> Hmm??
> 
> I tried iptables -A INPUT -j ACCEPT and it did not fix DCC.

It seems like you didn't understand the very basics of netfilter/iptables.
Please read the available HOWTO's. the INPUT chain of the filter table is
in no way related to any packet on your NAT box.

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
