Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129500AbRBGUwy>; Wed, 7 Feb 2001 15:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129063AbRBGUwe>; Wed, 7 Feb 2001 15:52:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44674 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129026AbRBGUwb>;
	Wed, 7 Feb 2001 15:52:31 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14977.46399.167035.94694@pizda.ninka.net>
Date: Wed, 7 Feb 2001 12:51:11 -0800 (PST)
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: single copy pipe/fifo
In-Reply-To: <3A81AE75.3CEF5577@colorfullife.com>
In-Reply-To: <3A81AE75.3CEF5577@colorfullife.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Manfred Spraul writes:
 > * if you run 2 instances on a dual cpu P II/350 it's a big win, but if
 > you run only one instance, then the bw_pipe processes will jump from one
 > cpu to the other and it's only a small improvement (~+15%).

wake_up_interruptible_sync is meant specifically to avoid
this cpu hopping behavior.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
