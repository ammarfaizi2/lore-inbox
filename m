Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWH3W1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWH3W1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWH3W1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:27:07 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2527
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932204AbWH3W1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:27:04 -0400
Date: Wed, 30 Aug 2006 15:27:05 -0700 (PDT)
Message-Id: <20060830.152705.27955313.davem@davemloft.net>
To: haveblue@us.ibm.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC][PATCH 5/9] sparc64 generic PAGE_SIZE
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060830221608.A33491C8@localhost.localdomain>
References: <20060830221604.E7320C0F@localhost.localdomain>
	<20060830221608.A33491C8@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 30 Aug 2006 15:16:08 -0700

> 
> This is the sparc64 portion to convert it over to the generic PAGE_SIZE
> framework.
> 
> * Change all references to CONFIG_SPARC64_PAGE_SIZE_*KB to
>   CONFIG_PAGE_SIZE_* and update the defconfig.
> * remove sparc64-specific Kconfig menu
> * add sparc64 default of 8k pages to mm/Kconfig
> * remove generic support for 4k pages
> * add support for 8k, 64k, 512k, and 4MB pages
> 
> Signed-off-by: Dave Hansen <haveblue@us.ibm.com>

Signed-off-by: David S. Miller <davem@davemloft.net>
