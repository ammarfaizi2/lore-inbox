Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268928AbRHPWe0>; Thu, 16 Aug 2001 18:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268933AbRHPWeQ>; Thu, 16 Aug 2001 18:34:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8576 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268928AbRHPWd6>;
	Thu, 16 Aug 2001 18:33:58 -0400
Date: Thu, 16 Aug 2001 15:31:51 -0700 (PDT)
Message-Id: <20010816.153151.74749641.davem@redhat.com>
To: tpepper@vato.org
Cc: f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010816144109.A5094@cb.vato.org>
In-Reply-To: <200108162111.XAA07177@db0bm.ampr.org>
	<20010816144109.A5094@cb.vato.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: tpepper@vato.org
   Date: Thu, 16 Aug 2001 14:41:09 -0700

   Confirmed here.  Looks like a pretty obvious goof to me.  Does the following
   fix it for you?

The args and semantics of min/max changed to take
a type first argument, the problem with this ntfs file is that it
fails to include linux/kernel.h

Later,
David S. Miller
davem@redhat.com
