Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265014AbSJRGne>; Fri, 18 Oct 2002 02:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265025AbSJRGne>; Fri, 18 Oct 2002 02:43:34 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52675 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265014AbSJRGnd>;
	Fri, 18 Oct 2002 02:43:33 -0400
Date: Thu, 17 Oct 2002 23:41:52 -0700 (PDT)
Message-Id: <20021017.234152.32199647.davem@redhat.com>
To: ak@muc.de
Cc: peter@chubb.wattle.id.au, bcrl@redhat.com, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] statfs64 no longer missing
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021018063129.GA24682@averell>
References: <15791.21383.361727.533851@wombat.chubb.wattle.id.au>
	<20021018061701.GA18925@clusterfs.com>
	<20021018063129.GA24682@averell>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@muc.de>
   Date: Fri, 18 Oct 2002 08:31:29 +0200

   > Wasn't Dave Miller just saying that passing "long" between user-space
   > and the kernel is just a bad idea?  Should we use "__u32" and "__u64"
   > here instead?
   
   This is architecture specific, where it is ok.

Well, it would be nice if we could put this into
asm-generic/statfs64.h and use portable types like
u64 et al.
