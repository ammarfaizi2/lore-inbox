Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262694AbSI1Dhr>; Fri, 27 Sep 2002 23:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262695AbSI1Dhr>; Fri, 27 Sep 2002 23:37:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46487 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262694AbSI1Dhr>;
	Fri, 27 Sep 2002 23:37:47 -0400
Date: Fri, 27 Sep 2002 20:36:06 -0700 (PDT)
Message-Id: <20020927.203606.32735488.davem@redhat.com>
To: kuznet@ms2.inr.ac.ru
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Improvement of Source Address Selection
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209280338.HAA02810@sex.inr.ac.ru>
References: <20020927.195507.87349906.davem@redhat.com>
	<200209280338.HAA02810@sex.inr.ac.ru>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: kuznet@ms2.inr.ac.ru
   Date: Sat, 28 Sep 2002 07:38:09 +0400 (MSD)

   Now I see retransmission of practicllay the same patch, which was deferred
   for improvement that time.

Ok, Yoshi please work Alexey to put source address selection into the
right place and remove ipv6_get_saddr().

Alexey, I still am not clear, this belongs in the output routing logic
right?  You dance in circles talking about this patch, that patch,
but what I cannot decode this into an answer to question of where
source address selection belongs.
