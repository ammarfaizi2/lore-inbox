Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270218AbRHMOP7>; Mon, 13 Aug 2001 10:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270219AbRHMOPt>; Mon, 13 Aug 2001 10:15:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15488 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270218AbRHMOPj>;
	Mon, 13 Aug 2001 10:15:39 -0400
Date: Mon, 13 Aug 2001 07:15:50 -0700 (PDT)
Message-Id: <20010813.071550.75187499.davem@redhat.com>
To: greearb@candelatech.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Low-Cost IP TOS bit won't clear.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3B7764DF.BF58692D@candelatech.com>
In-Reply-To: <3B7764DF.BF58692D@candelatech.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Sun, 12 Aug 2001 22:25:51 -0700

   I'm doing some experimenting with setting the various values of
   the IP TOS byte.  First (as I already mentioned on the linux-net
   mailing list) the IPTOS_* values in netinet/ip.h do not seem
   correct, they should be shifted left by 2 bits each, if I understand
   correctly...

You do not understand the bit layout correctly :-), and also see what
I mentioned about ECN if you are getting "stuck bits".

Later,
David S. Miller
davem@redhat.com
