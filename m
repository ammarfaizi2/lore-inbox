Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131194AbRC3IcH>; Fri, 30 Mar 2001 03:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131206AbRC3Ib5>; Fri, 30 Mar 2001 03:31:57 -0500
Received: from xerxes.thphy.uni-duesseldorf.de ([134.99.64.10]:63739 "EHLO
	xerxes.thphy.uni-duesseldorf.de") by vger.kernel.org with ESMTP
	id <S131194AbRC3Ibo>; Fri, 30 Mar 2001 03:31:44 -0500
Date: Fri, 30 Mar 2001 10:31:01 +0200 (CEST)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: hugang <linuxhappy@etang.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [ISDN-ERR]
In-Reply-To: <20010330100323.791a25c8.linuxhappy@etang.com>
Message-ID: <Pine.LNX.4.10.10103301027550.19330-100000@chaos.thphy.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Mar 2001, hugang wrote:

> Hello all:
> 	
> ---------------------------------------
> OPEN: 10.0.0.2 -> 202.99.16.1 UDP, port: 1024 -> 53
> ippp0: dialing 1 86310163...
> isdn: HiSax,ch0 cause: E001B			<--- error !!
> isdn_net: local hangup ippp0
> ippp0: Chargesum is 0
> ---------------------------------------

E001B is an ISDN cause (see "man isdn_cause") it means
Location: (00) local
Cause:    (1B) Destination out of order

which most likely indicates a cabling problem on your ISDN line. If you
need further assistance, contact me privately or ask on
isdn4linux@listserv.isdn4linux.de, people on l-k don't really care.

--Kai


