Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267265AbTCEP36>; Wed, 5 Mar 2003 10:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267267AbTCEP36>; Wed, 5 Mar 2003 10:29:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11962 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267265AbTCEP35>;
	Wed, 5 Mar 2003 10:29:57 -0500
Date: Wed, 05 Mar 2003 07:21:49 -0800 (PST)
Message-Id: <20030305.072149.121185037.davem@redhat.com>
To: kazunori@miyazawa.org
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi-core@linux-ipv6.org
Subject: Re: [PATH] IPv6 IPsec support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030305233025.784feb00.kazunori@miyazawa.org>
References: <20030305233025.784feb00.kazunori@miyazawa.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Kazunori Miyazawa <kazunori@miyazawa.org>
   Date: Wed, 5 Mar 2003 23:30:25 +0900

Hello Miyazawa-san,

   I submit the patch to let the kernel support ipv6 ipsec again.
   It is able to comple ipv6 as module.
   
   This patch incldes a couple of clean-up and
   changes of function name.

Excellent work.

I have comments, but they are very minor and can wait.
I will apply your patch after basic build testing.

The next large task will be to abstract out more common
pieces of code.  There is still quite a bit of code duplication
between v4 and v6 xfrm methods,

Thank you!
