Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262965AbSJGKaM>; Mon, 7 Oct 2002 06:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262967AbSJGKaM>; Mon, 7 Oct 2002 06:30:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45207 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262965AbSJGKaL>;
	Mon, 7 Oct 2002 06:30:11 -0400
Date: Mon, 07 Oct 2002 03:29:00 -0700 (PDT)
Message-Id: <20021007.032900.51704978.davem@redhat.com>
To: rth@twiddle.net
Cc: jakub@redhat.com, ak@muc.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use __attribute__((malloc)) for gcc 3.2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021007030541.A3910@twiddle.net>
References: <20020929152731.GA10631@averell>
	<20020929160113.K5659@devserv.devel.redhat.com>
	<20021007030541.A3910@twiddle.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Richard Henderson <rth@twiddle.net>
   Date: Mon, 7 Oct 2002 03:05:41 -0700

   On Sun, Sep 29, 2002 at 04:01:13PM -0400, Jakub Jelinek wrote:
   > Does this matter when the kernel is compiled with -fno-strict-aliasing?
   
   Yes.  The malloc attribute uses REG_NOALIAS, not alias sets.
   
Great, I'm all for Andi's patch in that case.
