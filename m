Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271276AbRHTPFj>; Mon, 20 Aug 2001 11:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271278AbRHTPFa>; Mon, 20 Aug 2001 11:05:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9107 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271276AbRHTPFV>;
	Mon, 20 Aug 2001 11:05:21 -0400
Date: Mon, 20 Aug 2001 08:03:34 -0700 (PDT)
Message-Id: <20010820.080334.68038516.davem@redhat.com>
To: jay@rgrs.com
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() says closed socket readable
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E15Yq81-0006o8-00@shell2.shore.net>
In-Reply-To: <200108181627.UAA19351@ms2.inr.ac.ru>
	<E15Yq81-0006o8-00@shell2.shore.net>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jay Rogers <jay@rgrs.com>
   Date: Mon, 20 Aug 2001 10:34:09 -0400

   > Right. It does not block on read, hence it is readable.
   
   No, a socket that's never been connected isn't readable, hence
   select() shouldn't be returning a value of 1 on it.

You may read without blocking, select() returns 1.

Please, fix your app.

Later,
David S. Miller
davem@redhat.com
