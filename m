Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317063AbSFKOQx>; Tue, 11 Jun 2002 10:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSFKOQv>; Tue, 11 Jun 2002 10:16:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6342 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317063AbSFKOQp>;
	Tue, 11 Jun 2002 10:16:45 -0400
Date: Tue, 11 Jun 2002 07:12:25 -0700 (PDT)
Message-Id: <20020611.071225.65985367.davem@redhat.com>
To: padraig@antefacto.com
Cc: remedy@mirotel.net, linux-kernel@vger.kernel.org
Subject: Re: net sysctls questions
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D06051C.3030305@antefacto.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Padraig Brady <padraig@antefacto.com>
   Date: Tue, 11 Jun 2002 15:11:40 +0100

   /proc/sys/net/ipv4/conf/../{arp_filter,tag}
   are not documented.
   
Nobody had time to document them, that is all.

   /proc/sys/net/ipv4/icmp_rate_limit is jiffies.
   Shouldn't this be HZ, i.e. jiffies shouldn't
   be exported to userspace as it's non portable?

What if you want to specify value smaller than HZ?
That is the most typical for this setting.
