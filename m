Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129507AbQLWOhq>; Sat, 23 Dec 2000 09:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129666AbQLWOhh>; Sat, 23 Dec 2000 09:37:37 -0500
Received: from coruscant.franken.de ([193.174.159.226]:47365 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S129507AbQLWOhY>; Sat, 23 Dec 2000 09:37:24 -0500
Date: Sat, 23 Dec 2000 15:04:08 +0100
From: Harald Welte <laforge@gnumonks.org>
To: John Covici <covici@ccs.covici.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 test12 ipchains doesn't work as module
Message-ID: <20001223150408.W5858@coruscant.gnumonks.org>
In-Reply-To: <m3lmtblvwf.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3lmtblvwf.fsf@ccs.covici.com>; from covici@ccs.covici.com on Tue, Dec 19, 2000 at 08:32:48PM -0500
X-Operating-System: 2.4.0-test11p4
X-Date: Today is Prickle-Prickle, the 62nd day of The Aftermath in the YOLD 3166
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2000 at 08:32:48PM -0500, John Covici wrote:
> I configured 2.4.0 test12 to use the ipchains compatability option as
> a module and I did a modprobe on all the other modules in that section
> of such as iptable_filter, etc.  When I tried to do the modprobe on
>  

I'm not sure if I understand you correctly, but it is _not_ possible
to use any of the two backwards compatibility modules in combination with
the new modules. Either you use ipchains backwards compatibility _or_
iptable_filter.

For more discussion about iptables/netfilter, join the netfilter mailinglist
(see http://netfilter.kernelnotes.org)

>          John Covici
>          covici@ccs.covici.com

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
