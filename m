Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312817AbSDOPDi>; Mon, 15 Apr 2002 11:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312828AbSDOPDh>; Mon, 15 Apr 2002 11:03:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:64903 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312817AbSDOPDh>;
	Mon, 15 Apr 2002 11:03:37 -0400
Date: Mon, 15 Apr 2002 07:55:36 -0700 (PDT)
Message-Id: <20020415.075536.69463397.davem@redhat.com>
To: kernel@Expansa.sns.it
Cc: joe@tmsusa.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.8 final -
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0204151607480.26730-100000@Expansa.sns.it>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Luigi Genoni <kernel@Expansa.sns.it>
   Date: Mon, 15 Apr 2002 16:15:04 +0200 (CEST)

   OH well, on sparc64 setup_per_cpu_areas()  simply is
   not declared, since it is not a GENERIC_PER_CPU.
   
   then asm/cacheflush.h, required by linux/highmem.h,
   does not exist.
   
   And then PREEMPT_ACTIVE is not defined...
   
   it seems that I could not test under sparc64 also this release, sigh!

I just haven't pushed my tree yet, it will be fixed soon.
I've been busy with other things this weekend...
