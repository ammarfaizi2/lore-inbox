Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbSJQAAH>; Wed, 16 Oct 2002 20:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261560AbSJQAAH>; Wed, 16 Oct 2002 20:00:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4534 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261558AbSJQAAG>;
	Wed, 16 Oct 2002 20:00:06 -0400
Date: Wed, 16 Oct 2002 16:58:34 -0700 (PDT)
Message-Id: <20021016.165834.71112730.davem@redhat.com>
To: hugh@veritas.com
Cc: willy@debian.org, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem missing cache flush
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0210170033320.1476-100000@localhost.localdomain>
References: <20021016192630.L15163@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.44.0210170033320.1476-100000@localhost.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hugh Dickins <hugh@veritas.com>
   Date: Thu, 17 Oct 2002 00:57:30 +0100 (BST)
   
   I would be much happier about adding it, if you could tell me that
   I can then remove the flush_page_to_ram(page) from shmem_nopage?
   
No we still have to support platforms using flush_page_to_ram()

I didn't get a chance to deprecate this in 2.5.x, I wish I had.
