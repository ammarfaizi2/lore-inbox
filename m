Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274217AbRISVzt>; Wed, 19 Sep 2001 17:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274221AbRISVzj>; Wed, 19 Sep 2001 17:55:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52615 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274217AbRISVz1>;
	Wed, 19 Sep 2001 17:55:27 -0400
Date: Wed, 19 Sep 2001 14:55:34 -0700 (PDT)
Message-Id: <20010919.145534.104033668.davem@redhat.com>
To: ebiederm@xmission.com
Cc: alan@lxorguk.ukuu.org.uk, phillips@bonn-fries.net, rfuller@nsisoftware.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: broken VM in 2.4.10-pre9
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <m1elp2g8vd.fsf@frodo.biederman.org>
In-Reply-To: <E15jnIB-0003gh-00@the-village.bc.nu>
	<m1elp2g8vd.fsf@frodo.biederman.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: ebiederm@xmission.com (Eric W. Biederman)
   Date: 19 Sep 2001 15:37:26 -0600
   
   That I think is a significant cost.

My own personal feeling, after having tried to implement a much
lighter weight scheme involving "anon areas", is that reverse maps or
something similar should be looked at as a latch ditch effort.

We are tons faster than anyone else in fork/exec/exit precisely
because we keep track of so little state for anonymous pages.

Later,
David S. Miller
davem@redhat.com
