Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278075AbRJJABW>; Tue, 9 Oct 2001 20:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278073AbRJJABN>; Tue, 9 Oct 2001 20:01:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18823 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S278074AbRJJABH>;
	Tue, 9 Oct 2001 20:01:07 -0400
Date: Tue, 09 Oct 2001 17:01:35 -0700 (PDT)
Message-Id: <20011009.170135.95895109.davem@redhat.com>
To: hiren_mehta@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: calling vmalloc inside interrupt handler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <01A7DAF31F93D511AEE300D0B706ED9208E48E@axcs13.cos.agilent.com>
In-Reply-To: <01A7DAF31F93D511AEE300D0B706ED9208E48E@axcs13.cos.agilent.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
   Date: Tue, 9 Oct 2001 17:55:48 -0600 

   It is allowed to call vmalloc/kmalloc inside interrupt handler ?

vmalloc() is not allowed, but kmalloc with GFP_ATOMIC flag is allowed

Franks a lot,
David S. Miller
davem@redhat.com
