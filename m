Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289833AbSAWMgY>; Wed, 23 Jan 2002 07:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289825AbSAWMgO>; Wed, 23 Jan 2002 07:36:14 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24448 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289833AbSAWMgB>;
	Wed, 23 Jan 2002 07:36:01 -0500
Date: Wed, 23 Jan 2002 04:34:41 -0800 (PST)
Message-Id: <20020123.043441.112625212.davem@redhat.com>
To: velco@fadata.bg
Cc: manfred@colorfullife.com, masp0008@stud.uni-saarland.de,
        drobbins@gentoo.org, linux-kernel@vger.kernel.org
Subject: Re: Athlon/AGP issue update
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <87wuy9b62u.fsf@fadata.bg>
In-Reply-To: <3C4E9291.8DA0BD7F@stud.uni-saarland.de>
	<20020123.034411.71089598.davem@redhat.com>
	<87wuy9b62u.fsf@fadata.bg>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Momchil Velikov <velco@fadata.bg>
   Date: 23 Jan 2002 14:32:57 +0200

   Erm, why would the granularity of mapping matter at all ?

Because on a TLB miss the speculative store would be cancelled.
With 4MB pages the TLB can hit, with 4K pages it cannot.

Franks a lot,
David S. Miller
davem@redhat.com
   
