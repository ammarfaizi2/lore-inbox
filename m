Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbTCYGhv>; Tue, 25 Mar 2003 01:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261480AbTCYGhv>; Tue, 25 Mar 2003 01:37:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:64209 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261476AbTCYGhu>;
	Tue, 25 Mar 2003 01:37:50 -0500
Date: Mon, 24 Mar 2003 22:46:27 -0800 (PST)
Message-Id: <20030324.224627.70037101.davem@redhat.com>
To: sfr@canb.auug.org.au
Cc: jgrimm2@us.ibm.com, linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] warning and unused in sctp.h
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030325142400.194987b0.sfr@canb.auug.org.au>
References: <20030325142400.194987b0.sfr@canb.auug.org.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephen Rothwell <sfr@canb.auug.org.au>
   Date: Tue, 25 Mar 2003 14:24:00 +1100
   
   This patch changes a flags argument to spin_lock_irq_save to unsigned long
   and removes its unused attribute.  The first gets rid of several warnings
   and the second is "obviously correct" (at least according to Rusty) :-).
   
Applied, thank you.

   Thanks to DaveM for forcing me to build kernels with a 64 cross compiler :-)

No problem. :)
