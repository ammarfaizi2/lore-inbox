Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312896AbSCZAmb>; Mon, 25 Mar 2002 19:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312898AbSCZAmV>; Mon, 25 Mar 2002 19:42:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:55189 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312896AbSCZAmL>;
	Mon, 25 Mar 2002 19:42:11 -0500
Date: Mon, 25 Mar 2002 16:37:39 -0800 (PST)
Message-Id: <20020325.163739.40148174.davem@redhat.com>
To: thunder@ngforever.de
Cc: mdrobnak@optonline.net, linux-kernel@vger.kernel.org
Subject: Re: More observations regarding IPv6 on PPC platform.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C9FC110.8010100@ngforever.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thunder from the hill <thunder@ngforever.de>
   Date: Mon, 25 Mar 2002 17:30:08 -0700

   Matthew Drobnak wrote:
   > While I was attempting to debug a little bit, I installed tcpdump to see 
   > if it was even seeing the router advertisements...Apparently it was..
   > 
   > On top of that, if you keep tcpdump running, IPv6 works fine!

   tcpdump keeps ethn in promiscuous mode. Maybe this is what was expected?
   
Smells like a multicast bug in the network driver/card.
