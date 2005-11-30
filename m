Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbVK3XvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVK3XvZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVK3XvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:51:25 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:62378 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751266AbVK3XvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:51:24 -0500
Message-ID: <438E3A47.9080803@jp.fujitsu.com>
Date: Thu, 01 Dec 2005 08:48:23 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: akpm@osdl.org, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Cliff Wickman <cpw@sgi.com>
Subject: Re: [Lhms-devel] [PATCH 4/7] Direct Migration V5: migrate_pages()
 extension
References: <20051128204244.10037.43868.sendpatchset@schroedinger.engr.sgi.com> <20051128204304.10037.81195.sendpatchset@schroedinger.engr.sgi.com> <438D6427.8060003@jp.fujitsu.com> <Pine.LNX.4.62.0511300834010.19142@schroedinger.engr.sgi.com> <438DE141.3030206@jp.fujitsu.com> <Pine.LNX.4.62.0511300940310.19602@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0511300940310.19602@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> 
> Do you think this patch would work? It allows migration of VM_SHM vmas and
> switches from checking page->mapping to page_mapping() in 
> migrate_page_remove_references.
> 
I think this would work.
I'll try your new set and this patch.

Thanks,
-- Kame

