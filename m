Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319737AbSIMS0L>; Fri, 13 Sep 2002 14:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319738AbSIMS0L>; Fri, 13 Sep 2002 14:26:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50379 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319737AbSIMS0L>;
	Fri, 13 Sep 2002 14:26:11 -0400
Date: Fri, 13 Sep 2002 11:22:35 -0700 (PDT)
Message-Id: <20020913.112235.27948638.davem@redhat.com>
To: buytenh@math.leidenuniv.nl
Cc: bart.de.schuymer@pandora.be, linux-kernel@vger.kernel.org
Subject: Re: bridge-netfilter patch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020913144518.A31318@math.leidenuniv.nl>
References: <200209130812.27093.bart.de.schuymer@pandora.be>
	<20020912.230916.96754743.davem@redhat.com>
	<20020913144518.A31318@math.leidenuniv.nl>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Lennert Buytenhek <buytenh@math.leidenuniv.nl>
   Date: Fri, 13 Sep 2002 14:45:18 +0200

   > You need to remove the IPv4 bits, that copy of the MAC has to happen
   > at a different layer, it does not belong in IPv4.  At best, everyone
   > shouldn't eat that header copy.
   
   What if I make the memcpy conditional on "if (skb->physindev != NULL)"?

First explain to me why the copy is needed for.

