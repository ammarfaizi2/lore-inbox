Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129744AbRAOQ3z>; Mon, 15 Jan 2001 11:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129774AbRAOQ3p>; Mon, 15 Jan 2001 11:29:45 -0500
Received: from ns.lin-gen.com ([195.64.80.163]:4736 "EHLO server")
	by vger.kernel.org with ESMTP id <S129744AbRAOQ3a>;
	Mon, 15 Jan 2001 11:29:30 -0500
Date: Mon, 15 Jan 2001 17:29:07 +0100
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Hans Grobler <grobh@sun.ac.za>, linux-kernel@vger.kernel.org
Subject: Re: PRoblem with pcnet32 under 2.4.0 , was :Drivers under 2.4
Message-ID: <20010115172907.A1708@lin-gen.com>
Reply-To: dth@lin-gen.com
In-Reply-To: <93kn8a$itt$1@voyager.cistron.net> <Pine.LNX.4.30.0101111836460.30013-100000@prime.sun.ac.za> <20010112125010.A6371@lin-gen.com> <20010112233332.C2501@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010112233332.C2501@alpha.franken.de>; from tsbogend@alpha.franken.de on Fri, Jan 12, 2001 at 11:33:32PM +0100
X-NCC-RegID: com.lin-gen
From: Danny ter Haar <dth@lin-gen.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I experimented some further today.

using some printk i found out is was setting Fullduplex,
hardcoded that to half-duplex (mine is connected to a hub
and not a switch) , and it's configuration was 100Mbit
as it was supposed to.

Then i started looking at the start_xmit code and got
lost :-)))

Hope this helpes to pin-point the problem.

Danny
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
