Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281777AbRK1LKY>; Wed, 28 Nov 2001 06:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281877AbRK1LKO>; Wed, 28 Nov 2001 06:10:14 -0500
Received: from bagel.indexdata.dk ([212.242.69.115]:4033 "EHLO
	bagel.indexdata.dk") by vger.kernel.org with ESMTP
	id <S281777AbRK1LKE>; Wed, 28 Nov 2001 06:10:04 -0500
Date: Wed, 28 Nov 2001 12:10:02 +0100
From: Heikki Levanto <heikki@indexdata.dk>
To: linux-kernel@vger.kernel.org
Subject: Thank you: 2.4.16: "Address family not supported" on RH IBM T23
Message-ID: <20011128121002.B17183@indexdata.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks to all who helped me out with this. The problem was CONFIG_NETLINK
and CONFIG_RTNETLINK, which I had not got around to trying. 

I guess this problem will pop up again in the future, when more RH7.2 users
want to compile their own kernels. Therefore it would be good to default
those options to yes, or even remove the options completely, as has been
proposed.


- Heikki


P.S. 
On Tue, Nov 27, 2001 at 11:23:23PM -0000, Alex Bligh - linux-kernel wrote:
> AGP support is broken right now, haven't found out why.
> The netlink error sounds like CONFIG_NETLINK, and/or
> CONFIG_RTNETLINK isn't set. Try stealing the .config
> file off my site.

Thanks! Didn't get your site, didn't get google cache. Will look again in
the near future. 


-- 
Heikki Levanto            heikki@indexdata.dk            "In Murphy We Turst"
