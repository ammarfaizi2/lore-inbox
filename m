Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbTA1VEY>; Tue, 28 Jan 2003 16:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbTA1VEX>; Tue, 28 Jan 2003 16:04:23 -0500
Received: from rth.ninka.net ([216.101.162.244]:38840 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S261286AbTA1VEU>;
	Tue, 28 Jan 2003 16:04:20 -0500
Subject: Re: IPSec tools
From: "David S. Miller" <davem@redhat.com>
To: latten@austin.ibm.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200301282100.h0SL0RM32440@faith.austin.ibm.com>
References: <200301282100.h0SL0RM32440@faith.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Jan 2003 13:53:25 -0800
Message-Id: <1043790805.23386.2.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-28 at 13:00, latten@austin.ibm.com wrote:
> Is the direction to definitely use the KAME-based setkey and racoon
> programs?

Yes.

> If so, where will the ports of these programs live, on the KAME
> site or somewhere else?  While setkey seems to be working very well, racoon
> is experiencing some problems.  The availability of the ported source code
> would allow for some debugging work to be performed.

Initially we had a hacked copy distributed in iputils, but the KAME
folks have integrated all of our changes into their current sources.

Our initial port is at:

ftp://ftp.inr.ac.ru/ip-routing/iputils-ss021109-try.tar.bz2

but like I said the setkey/racoon in KAME's current sources should
just work.

