Return-Path: <linux-kernel-owner+w=401wt.eu-S932694AbWL2E5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbWL2E5H (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 23:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbWL2E5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 23:57:07 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:57756
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932697AbWL2E5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 23:57:05 -0500
Date: Thu, 28 Dec 2006 20:57:04 -0800 (PST)
Message-Id: <20061228.205704.55509512.davem@davemloft.net>
To: balbir@in.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc2] Fix set_pte_at arguments in page_mkclean_one
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061229041310.1217.32072.sendpatchset@balbir.in.ibm.com>
References: <20061229041310.1217.32072.sendpatchset@balbir.in.ibm.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balbir Singh <balbir@in.ibm.com>
Date: Fri, 29 Dec 2006 09:43:10 +0530

> page_mkclean_one() passes vma instead of the expected mm as argument1 to
> set_pte_at. Below is a simple fix (tested by compiling the kernel on
> powerpc). Please ignore the patch, if a fix has already been applied.
> 
> Signed-off-by: Balbir Singh <balbir@in.ibm.com>

Good catch.

Signed-off-by: David S. Miller <davem@davemloft.net>
