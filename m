Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318033AbSG2Fv6>; Mon, 29 Jul 2002 01:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318035AbSG2Fv5>; Mon, 29 Jul 2002 01:51:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4068 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318033AbSG2Fvy>;
	Mon, 29 Jul 2002 01:51:54 -0400
Date: Sun, 28 Jul 2002 22:43:52 -0700 (PDT)
Message-Id: <20020728.224352.62250851.davem@redhat.com>
To: akpm@zip.com.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D44C1C8.C1617A09@zip.com.au>
References: <20020728.195055.105468330.davem@redhat.com>
	<Pine.LNX.4.44.0207282048230.913-100000@home.transmeta.com>
	<3D44C1C8.C1617A09@zip.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Sun, 28 Jul 2002 21:17:12 -0700

   hmm.  ia32's do_IRQ() doesn't run do_sotfirq() any more, but the
   other architectures do.  What's up with that?
   
Lots of architectes haven't caught up with Ingo's IRQ changes.  That
is the changeset where the do_softirq() call in do_IRQ() got deleted
on x86.

Franks a lot,
David S. Miller
davem@redhat.com
