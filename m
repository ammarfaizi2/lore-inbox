Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbSBGF6C>; Thu, 7 Feb 2002 00:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279798AbSBGF5v>; Thu, 7 Feb 2002 00:57:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:59030 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281214AbSBGF5o>;
	Thu, 7 Feb 2002 00:57:44 -0500
Date: Wed, 06 Feb 2002 21:55:39 -0800 (PST)
Message-Id: <20020206.215539.33252283.davem@redhat.com>
To: akpm@zip.com.au
Cc: bcrl@redhat.com, hugh@veritas.com, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C6214F0.A66C89CF@zip.com.au>
In-Reply-To: <Pine.LNX.4.21.0202061844450.1856-100000@localhost.localdomain>
	<20020207000930.A17125@redhat.com>
	<3C6214F0.A66C89CF@zip.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Wed, 06 Feb 2002 21:47:28 -0800
   
   Are you sure that the pages are being released from interrupt context?

BH context... that's where SKB frees happen.

hmmm...

