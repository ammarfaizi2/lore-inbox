Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266243AbUHII1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUHII1t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 04:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266254AbUHII1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 04:27:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:33673 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266243AbUHII1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 04:27:41 -0400
Date: Mon, 9 Aug 2004 01:25:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, mjbligh@us.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: 2.6.8-rc3-mm2
Message-Id: <20040809012555.4ca63fcb.akpm@osdl.org>
In-Reply-To: <200408090820.i798Kbj07417@owlet.beaverton.ibm.com>
References: <20040808152936.1ce2eab8.akpm@osdl.org>
	<200408090820.i798Kbj07417@owlet.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Lindsley <ricklind@us.ibm.com> wrote:
>
> Got complaints from arch/i386/mm/discontig.c:
> 
> arch/i386/mm/discontig.c: In function `zone_sizes_init':
> arch/i386/mm/discontig.c:422: warning: passing arg 4 of `free_area_init_node' makes integer from pointer without a cast
> arch/i386/mm/discontig.c:422: warning: passing arg 5 of `free_area_init_node' makes pointer from integer without a cast
> arch/i386/mm/discontig.c:422: too many arguments to function `free_area_init_node'
> arch/i386/mm/discontig.c:430: warning: passing arg 3 of `free_area_init_node' from incompatible pointer type
> arch/i386/mm/discontig.c:430: warning: passing arg 4 of `free_area_init_node' makes integer from pointer without a cast
> arch/i386/mm/discontig.c:430: warning: passing arg 5 of `free_area_init_node' makes pointer from integer without a cast
> arch/i386/mm/discontig.c:430: too many arguments to function `free_area_init_node'
> 
> Looks like I can't get by with just deleting the third argument in the
> second case.

Gargh.  I really want to ritually incinerate that damn patch.

Please send .config.
