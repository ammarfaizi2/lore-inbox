Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267992AbTBMJXt>; Thu, 13 Feb 2003 04:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267995AbTBMJXt>; Thu, 13 Feb 2003 04:23:49 -0500
Received: from pizda.ninka.net ([216.101.162.242]:51864 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267992AbTBMJXs>;
	Thu, 13 Feb 2003 04:23:48 -0500
Date: Thu, 13 Feb 2003 01:19:03 -0800 (PST)
Message-Id: <20030213.011903.32136660.davem@redhat.com>
To: neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Routing problem with udp, and a multihomed host in 2.4.20
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15947.25922.785515.945307@notabene.cse.unsw.edu.au>
References: <15946.54853.37531.810342@notabene.cse.unsw.edu.au>
	<1045120278.5115.0.camel@rth.ninka.net>
	<15947.25922.785515.945307@notabene.cse.unsw.edu.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Neil Brown <neilb@cse.unsw.edu.au>
   Date: Thu, 13 Feb 2003 20:28:34 +1100

   On  February 12, davem@redhat.com wrote:
   > On Wed, 2003-02-12 at 15:18, Neil Brown wrote:
   > > Is this a bug, or is there some configuration I can change?
   > 
   > Specify the correct 'src' parameter in your 'ip' route
   > command invocations.
   
   Thanks... but I think I need a bit more help.
   
Sorry, I forgot to add that you need to enable the
arp_filter sysctl as well to make this work properly.

It should work once you do this.
