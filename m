Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273747AbRI0Tmk>; Thu, 27 Sep 2001 15:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273832AbRI0Tma>; Thu, 27 Sep 2001 15:42:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9862 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S273747AbRI0TmV>;
	Thu, 27 Sep 2001 15:42:21 -0400
Date: Thu, 27 Sep 2001 12:41:34 -0700 (PDT)
Message-Id: <20010927.124134.28787324.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: torvalds@transmeta.com, bcrl@redhat.com, marcelo@conectiva.com.br,
        andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E15ma09-0003p9-00@the-village.bc.nu>
In-Reply-To: <20010926.162655.79011481.davem@redhat.com>
	<E15ma09-0003p9-00@the-village.bc.nu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Thu, 27 Sep 2001 13:10:49 +0100 (BST)

   See prefetching - the CPU prefetching will hide some of the effect and
   the spin_lock_prefetch() macro does wonders for the rest.
   
Well, if prefetching can do it faster than avoiding the transaction
altogether, I'm game :-)

Franks a lot,
David S. Miller
davem@redhat.com
