Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291620AbSBAJKE>; Fri, 1 Feb 2002 04:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291621AbSBAJJq>; Fri, 1 Feb 2002 04:09:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:28548 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291620AbSBAJJc>;
	Fri, 1 Feb 2002 04:09:32 -0500
Date: Fri, 01 Feb 2002 01:07:44 -0800 (PST)
Message-Id: <20020201.010744.35469747.davem@redhat.com>
To: mingo@elte.hu
Cc: velco@fadata.bg, anton@samba.org, torvalds@transmeta.com, andrea@suse.de,
        riel@conectiva.com.br, stoffel@casc.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0202011125030.5026-100000@localhost.localdomain>
In-Reply-To: <87u1t1ws20.fsf@fadata.bg>
	<Pine.LNX.4.33.0202011125030.5026-100000@localhost.localdomain>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ingo Molnar <mingo@elte.hu>
   Date: Fri, 1 Feb 2002 11:29:53 +0100 (CET)
   
   using read-write locks does not solve the scalability problem: the problem
   is the bouncing of the spinlock cacheline from CPU to CPU.

I so much wish more people understood this :(
