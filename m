Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130090AbQJ2Bti>; Sat, 28 Oct 2000 21:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129535AbQJ2BtT>; Sat, 28 Oct 2000 21:49:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47499 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130090AbQJ2BtI>;
	Sat, 28 Oct 2000 21:49:08 -0400
Date: Sat, 28 Oct 2000 18:34:55 -0700
Message-Id: <200010290134.SAA08597@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: ak@suse.de
CC: marcelo@conectiva.com.br, ak@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20001029021642.A16126@gruyere.muc.suse.de> (message from Andi
	Kleen on Sun, 29 Oct 2000 02:16:42 +0100)
Subject: Re: tcp_do_sendmsg() allocation still broken ?
In-Reply-To: <20001029020311.A16003@gruyere.muc.suse.de> <Pine.LNX.4.21.0010282108150.1319-100000@freak.distro.conectiva> <20001029021642.A16126@gruyere.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Sun, 29 Oct 2000 02:16:42 +0100
   From: Andi Kleen <ak@suse.de>

   On Sat, Oct 28, 2000 at 09:13:27PM -0200, Marcelo Tosatti wrote:
   > Think about nbd. 

   Making tcp_do_sendmsg use GFP_ATOMIC would make it too unreliable for other
   situations. Penalizing the whole system just for nbd is not a good idea.

Andi, sk->allocation not GFP_ATOMIC.

This is such an old topic Andi, I am surprised you forget all these details
so quickly.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
