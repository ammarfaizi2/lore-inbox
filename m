Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSIIJG7>; Mon, 9 Sep 2002 05:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316683AbSIIJG7>; Mon, 9 Sep 2002 05:06:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33437 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316675AbSIIJG6>;
	Mon, 9 Sep 2002 05:06:58 -0400
Date: Mon, 09 Sep 2002 02:04:00 -0700 (PDT)
Message-Id: <20020909.020400.72665590.davem@redhat.com>
To: taka@valinux.co.jp
Cc: scott.feldman@intel.com, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS for 2.5.33
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020909.175821.108746773.taka@valinux.co.jp>
References: <20020909.161123.74745039.taka@valinux.co.jp>
	<20020909.001902.28439948.davem@redhat.com>
	<20020909.175821.108746773.taka@valinux.co.jp>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hirokazu Takahashi <taka@valinux.co.jp>
   Date: Mon, 09 Sep 2002 17:58:21 +0900 (JST)

   As far as I know e1000 has a feature that it can split a jumbo UDP frame
   into some IP fragments.
   
I doubt this, because very rarely do vendors of commodity networking
cards implement things outside of Microsoft's NDIS (Network Driver
Interface Specification) and what I have described is what they define
for fragmentation offloading.

Maybe some new revision has the feature you suggest.

