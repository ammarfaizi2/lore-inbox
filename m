Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315466AbSEHAS1>; Tue, 7 May 2002 20:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315467AbSEHAS0>; Tue, 7 May 2002 20:18:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61602 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315466AbSEHAS0>;
	Tue, 7 May 2002 20:18:26 -0400
Date: Tue, 07 May 2002 17:06:21 -0700 (PDT)
Message-Id: <20020507.170621.93600738.davem@redhat.com>
To: colin@gibbs.dhs.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: bug in fork failure path?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1019178622.25887.630.camel@monolith>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Colin Gibbs <colin@gibbs.dhs.org>
   Date: 18 Apr 2002 20:10:22 -0500
   
   Can we move the init_new_context to just after the mm_init call? Works
   nicely on sparc. Most archs have a fairly trivial init_new_context
   anyway. 

I've put this fix into my trees to make sure it doesn't get
lost.  Thanks for spotting it.
