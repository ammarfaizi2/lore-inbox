Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261744AbSIZAiX>; Wed, 25 Sep 2002 20:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261745AbSIZAiX>; Wed, 25 Sep 2002 20:38:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21377 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261744AbSIZAiW>;
	Wed, 25 Sep 2002 20:38:22 -0400
Date: Wed, 25 Sep 2002 17:37:28 -0700 (PDT)
Message-Id: <20020925.173728.08323077.davem@redhat.com>
To: nf@hipac.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
 for Netfilter
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209260238.06400.nf@hipac.org>
References: <200209260041.56374.nf@hipac.org>
	<20020925.155246.41632313.davem@redhat.com>
	<200209260238.06400.nf@hipac.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: nf@hipac.org
   Date: Thu, 26 Sep 2002 02:38:06 +0200
   
   > You missed the real trick, extending the routing tables to
   > do packet filter rule lookup.  That's where the real
   > performance gains can be found, ...
   
   Yes, that's certainly true. But we have to take step by step.

All the work you will spend to validate all the converted modules
will be equal if not greater to doing the algorithm correctly.

So why not do it correctly from the start? :-)

Seriously, just sit tight with your work, and once the stackable
route stuff is done, you can look into applying your algorithms
to the new flow cache.
