Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135290AbRAFXjz>; Sat, 6 Jan 2001 18:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135293AbRAFXjq>; Sat, 6 Jan 2001 18:39:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:40849 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135290AbRAFXjc>;
	Sat, 6 Jan 2001 18:39:32 -0500
Date: Sat, 6 Jan 2001 15:22:09 -0800
Message-Id: <200101062322.PAA13439@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: manfred@colorfullife.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <3A57A95C.A1411221@colorfullife.com> (message from Manfred on
	Sun, 07 Jan 2001 00:25:16 +0100)
Subject: Re: [patch] single copy pipe rewrite
In-Reply-To: <3A57A95C.A1411221@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Sun, 07 Jan 2001 00:25:16 +0100
   From: Manfred <manfred@colorfullife.com>

   Last march David Miller proposed using kiobuf for these data
   transfers, I've written a new patch for 2.4.

   (David's original patch contained 2 bugs: it doesn't protect
   properly against multiple writers and it causes a BUG() in
   pipe_read() when data is stored in both the kiobuf and the normal
   buffer)

A couple months ago David posted a revised version of his patch which
fixed both these and some other problems.  Most of the fixes were done
by Alexey Kuznetsov.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
