Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265347AbSJXIRl>; Thu, 24 Oct 2002 04:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265348AbSJXIRk>; Thu, 24 Oct 2002 04:17:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32139 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265347AbSJXIRk>;
	Thu, 24 Oct 2002 04:17:40 -0400
Date: Thu, 24 Oct 2002 01:15:12 -0700 (PDT)
Message-Id: <20021024.011512.08605370.davem@redhat.com>
To: laforge@gnumonks.org
Cc: bart.de.schuymer@pandora.be, coreteam@netfilter.org,
       linux-kernel@vger.kernel.org, buytenh@gnu.org
Subject: Re: [netfilter-core] [RFC] place to put bridge-netfilter specific
 data in the skbuff
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021024101656.T2450@sunbeam.de.gnumonks.org>
References: <200210141953.38933.bart.de.schuymer@pandora.be>
	<200210142159.49290.bart.de.schuymer@pandora.be>
	<20021024101656.T2450@sunbeam.de.gnumonks.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Harald Welte <laforge@gnumonks.org>
   Date: Thu, 24 Oct 2002 10:16:56 +0200

   Mh. Since bridging firewall is cool, but not something everybody will
   use by default [and it adds code as well as enlarges the skb], I think it 
   should be a compiletime kernel config option.
   
This was my initial reaction, but both of us misunderstand what
is going on I think.

If you use bridging, using netfilter on the bridged traffic "is not
possible" without these bridge-netfilter changes.

So he's saying, if we have bridging enable and netfilter, should
bridge-netfilter be on, and right now I say yes.

Bart, correct me if I'm wrong.
