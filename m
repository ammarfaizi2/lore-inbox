Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262674AbSI1BVr>; Fri, 27 Sep 2002 21:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262675AbSI1BVq>; Fri, 27 Sep 2002 21:21:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37014 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262674AbSI1BVq>;
	Fri, 27 Sep 2002 21:21:46 -0400
Date: Fri, 27 Sep 2002 18:20:01 -0700 (PDT)
Message-Id: <20020927.182001.122314480.davem@redhat.com>
To: kuznet@ms2.inr.ac.ru
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Refine IPv6 Address Validation Timer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209271639.UAA21514@sex.inr.ac.ru>
References: <20020928.011439.108856769.yoshfuji@linux-ipv6.org>
	<200209271639.UAA21514@sex.inr.ac.ru>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: kuznet@ms2.inr.ac.ru
   Date: Fri, 27 Sep 2002 20:39:45 +0400 (MSD)
   
   > (do I need to resend complete patch?)
   
   No, I think. Deletion of bad debugging is easier to make after patching.

I've applied the patch with the time_after() debugging check
removed to both 2.4.x and 2.5.x

If, after discussion, the "HZ --> HZ/2" change needs to be made, just
send another patch on top of previous one, thanks.
