Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130635AbQLYPjj>; Mon, 25 Dec 2000 10:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131150AbQLYPj3>; Mon, 25 Dec 2000 10:39:29 -0500
Received: from coruscant.franken.de ([193.174.159.226]:7945 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S130635AbQLYPjR>; Mon, 25 Dec 2000 10:39:17 -0500
Date: Mon, 25 Dec 2000 16:06:21 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Mike Elmore <mwelmor@kre8tive.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Masquerade hangups
Message-ID: <20001225160621.L6217@coruscant.gnumonks.org>
In-Reply-To: <20001224090212.A1218@kre8tive.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001224090212.A1218@kre8tive.org>; from mwelmor@kre8tive.org on Sun, Dec 24, 2000 at 09:02:12AM -0600
X-Operating-System: 2.4.0-test11p4
X-Date: Today is Boomtime, the 65th day of The Aftermath in the YOLD 3166
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 24, 2000 at 09:02:12AM -0600, Mike Elmore wrote:
> Hello,
> 
> 
> I seem to get pretty good performance from 
> internet->masq box and from masq box->internal
> lan, but when a internal box tries to get to the
> net through the masquerade, connection seem to time
> out.  I'll get a pretty good initial burst, then
> connections stall.

please join the netfilter/iptables mailinglist (instructions on
http://netfilter.kernelnotes.org) and file us a detailed report.

It's a good idea to save linux-kernel from all the nifty details :)

> I'm using test13-pre4.  I saw some iptables stuff on
> the list a week or so ago, was this fixed in pre4 or
> is this my problem?

we (the netfilter core team) are currently not aware
of any bugs at the moment. The behaviour you've described
wasn't reported by anybody else.

> -mwe
> mike@kre8tive.org

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
