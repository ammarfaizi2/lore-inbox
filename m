Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267829AbTCFE7b>; Wed, 5 Mar 2003 23:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267835AbTCFE7b>; Wed, 5 Mar 2003 23:59:31 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24255 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267829AbTCFE7a>;
	Wed, 5 Mar 2003 23:59:30 -0500
Date: Wed, 05 Mar 2003 20:51:06 -0800 (PST)
Message-Id: <20030305.205106.113457587.davem@redhat.com>
To: jmorris@intercode.com.au
Cc: otter@surfnet.nl, brian@top.worldcontrol.com, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Booting 2.5.63 vs 2.4.20 I can't read multicast
 data
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0303061605001.27962-100000@blackbird.intercode.com.au>
References: <20030304223953.GA3114@pangsit>
	<Pine.LNX.4.44.0303061605001.27962-100000@blackbird.intercode.com.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Morris <jmorris@intercode.com.au>
   Date: Thu, 6 Mar 2003 16:06:46 +1100 (EST)

   On Tue, 4 Mar 2003, Niels den Otter wrote:
   
   > You appear to be strugling with the same problem I have. What I find is
   > that the multicast application binds to the loopback instead of ethernet
   > interface (also no IGMP joins are send out on the ethernet interface).
   
   Please try the patch below.
   
Oops, a typo of mine during the flowi changes for ipsec, my bad.

Good spotting James.
