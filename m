Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318255AbSIBKH6>; Mon, 2 Sep 2002 06:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318256AbSIBKH6>; Mon, 2 Sep 2002 06:07:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28874 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318255AbSIBKH5>;
	Mon, 2 Sep 2002 06:07:57 -0400
Date: Mon, 02 Sep 2002 03:05:53 -0700 (PDT)
Message-Id: <20020902.030553.14354294.davem@redhat.com>
To: phillips@arcor.de
Cc: wli@holomorphy.com, rml@tech9.net, rusty@rustcorp.com.au,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E17loBW-0004gM-00@starship>
References: <20020902060257.GO888@holomorphy.com>
	<20020901.232021.00308364.davem@redhat.com>
	<E17loBW-0004gM-00@starship>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Daniel Phillips <phillips@arcor.de>
   Date: Mon, 2 Sep 2002 12:11:53 +0200

   On Monday 02 September 2002 08:20, David S. Miller wrote:
   > The problem is, it isn't a "list", it's a "list header" or "list
   > marker", ie. a list_head.
   
   No it's not, it's nothing more nor less than a list node, identically,
   a list.
   
A list node is markably different from "the list" itself.

A "list" is the whole of all the nodes on the list, not just one
of them.
