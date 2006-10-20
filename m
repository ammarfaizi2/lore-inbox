Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946530AbWJTVax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946530AbWJTVax (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423237AbWJTVaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:30:52 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11488
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422979AbWJTVav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:30:51 -0400
Date: Fri, 20 Oct 2006 14:30:51 -0700 (PDT)
Message-Id: <20061020.143051.102576722.davem@davemloft.net>
To: rmk+lkml@arm.linux.org.uk
Cc: torvalds@osdl.org, nickpiggin@yahoo.com.au, ralf@linux-mips.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp,
       linux-arch@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061020211723.GF8894@flint.arm.linux.org.uk>
References: <20061020205929.GE8894@flint.arm.linux.org.uk>
	<20061020.140619.11628819.davem@davemloft.net>
	<20061020211723.GF8894@flint.arm.linux.org.uk>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Fri, 20 Oct 2006 22:17:23 +0100

> I did say I had a VIVT cache.

And everything I said was premised with this understanding :-)
