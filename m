Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWBVCfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWBVCfA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 21:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWBVCfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 21:35:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21647 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750725AbWBVCfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 21:35:00 -0500
Date: Tue, 21 Feb 2006 18:33:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, haveblue@us.ibm.com,
       Christoph Lameter <christoph@lameter.com>
Subject: Re: [PATCH] remove zone_mem_map
Message-Id: <20060221183306.3d467d14.akpm@osdl.org>
In-Reply-To: <43FBAEBA.2020300@jp.fujitsu.com>
References: <43FBAEBA.2020300@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
> This patch removes zone_mem_map from zone.
>  By this, (generic) page_to_pfn and pfn_to_page can use the same logic.

I assume this is dependent upon unify-pfn_to_page-*.patch?

>  This modifies page_to_pfn implementation. Could anyone do performance test on NUMA ?

Do you expect there to be NUMA performance problems?  If so, how do they
arise and what sort of tests should be run?

