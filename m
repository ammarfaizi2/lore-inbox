Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288092AbSAVBKu>; Mon, 21 Jan 2002 20:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289119AbSAVBKk>; Mon, 21 Jan 2002 20:10:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:47282 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S288092AbSAVBKZ>;
	Mon, 21 Jan 2002 20:10:25 -0500
Date: Mon, 21 Jan 2002 17:08:22 -0800 (PST)
Message-Id: <20020121.170822.32749723.davem@redhat.com>
To: andrea@suse.de
Cc: akpm@zip.com.au, reid.hekman@ndsu.nodak.edu, linux-kernel@vger.kernel.org,
        alan@lxorg.ukuu.org
Subject: Re: Athlon PSE/AGP Bug
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020122013909.N8292@athlon.random>
In-Reply-To: <3C4C5B26.3A8512EF@zip.com.au>
	<20020121.142320.123999571.davem@redhat.com>
	<20020122013909.N8292@athlon.random>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Tue, 22 Jan 2002 01:39:09 +0100

   On Mon, Jan 21, 2002 at 02:23:20PM -0800, David S. Miller wrote:
   > I think this is all "just so happens" personally, and all the that
   > turning off the large pages really does is change the timings so that
   > whatever bug is really present simply becomes a heisenbug.
   
   My same wondering, however I wasn't sure how much the timing could
   really change to make the kernel bugs trigger.

Not kernel bugs, things like AGP bugs under high load which would
go away if the machine spent more time taking kernel TLB misses.
