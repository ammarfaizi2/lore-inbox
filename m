Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261842AbSJNGQq>; Mon, 14 Oct 2002 02:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261844AbSJNGQq>; Mon, 14 Oct 2002 02:16:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52117 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261842AbSJNGQq>;
	Mon, 14 Oct 2002 02:16:46 -0400
Date: Sun, 13 Oct 2002 23:15:34 -0700 (PDT)
Message-Id: <20021013.231534.08939486.davem@redhat.com>
To: neilb@cse.unsw.edu.au
Cc: taka@valinux.co.jp, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] zerocopy NFS for 2.5.36
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15786.23306.84580.323313@notabene.cse.unsw.edu.au>
References: <20020918.171431.24608688.taka@valinux.co.jp>
	<15786.23306.84580.323313@notabene.cse.unsw.edu.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Neil Brown <neilb@cse.unsw.edu.au>
   Date: Mon, 14 Oct 2002 15:50:02 +1000

    Would you like to see if davem is happy with that bit first and get
    it in?  Then I will be happy to forward the nfsd specific bit.
   
Alexey is working on this, or at least he was. :-)
(Alexey this is about the UDP cork changes)

    I'm bit I'm not very sure about is the 'shadowsock' patch for having
    several xmit sockets, one per CPU.  What sort of speedup do you get
    from this?  How important is it really?
   
Personally, it seems rather essential for scalability on SMP.
