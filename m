Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbVIQHTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbVIQHTn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 03:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbVIQHTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 03:19:43 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:9710
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750971AbVIQHTn (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 03:19:43 -0400
Date: Sat, 17 Sep 2005 00:19:37 -0700 (PDT)
Message-Id: <20050917.001937.131223540.davem@davemloft.net>
To: zippel@linux-m68k.org
Cc: nickpiggin@yahoo.com.au, rmk+lkml@arm.linux.org.uk,
       Linux-Kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [PATCH 2/5] atomic: introduce atomic_inc_not_zero
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0509170300030.3743@scrub.home>
References: <20050914232106.H30746@flint.arm.linux.org.uk>
	<4328D39C.2040500@yahoo.com.au>
	<Pine.LNX.4.61.0509170300030.3743@scrub.home>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Zippel <zippel@linux-m68k.org>
Date: Sat, 17 Sep 2005 03:15:29 +0200 (CEST)

> The main problem is here that the atomic functions are used in two basic 
> situation:
> 
> 1) interrupt synchronization
> 2) multiprocessor synchronization

3) preempt synchronization
