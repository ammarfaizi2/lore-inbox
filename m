Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271939AbRIDK33>; Tue, 4 Sep 2001 06:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271932AbRIDK3T>; Tue, 4 Sep 2001 06:29:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60553 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271933AbRIDK3K>;
	Tue, 4 Sep 2001 06:29:10 -0400
Date: Tue, 04 Sep 2001 03:29:25 -0700 (PDT)
Message-Id: <20010904.032925.74563055.davem@redhat.com>
To: ak@suse.de
Cc: jeffm@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [SOLVED + PATCH]: documented Oops running big-endian reiserfs
 on parisc architecture
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010904122524.A26403@gruyere.muc.suse.de>
In-Reply-To: <oupoforxpc1.fsf@pigdrop.muc.suse.de>
	<20010904.030454.85412225.davem@redhat.com>
	<20010904122524.A26403@gruyere.muc.suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Tue, 4 Sep 2001 12:25:24 +0200

   On Tue, Sep 04, 2001 at 03:04:54AM -0700, David S. Miller wrote:
   > I can also almost guarentee you that the x86 will sometimes not
   > execute these bitops atomically on SMP.
   
   It's not needed when you have another lock to protect and don't have
   interrupt threads.

I agree completely, so therefore if moving to non-atomic bitops
is an option that would be a great way to fix this reiserfs bug.

Later,
David S. Miller
davem@redhat.com
