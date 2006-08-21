Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751649AbWHUNcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbWHUNcv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 09:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWHUNcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 09:32:50 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:39442 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751649AbWHUNcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 09:32:50 -0400
Message-ID: <44E9B69D.9060109@sw.ru>
Date: Mon, 21 Aug 2006 17:35:25 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dave Hansen <haveblue@us.ibm.com>, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Christoph@sc8-sf-spam2-b.sourceforge.net,
       List <linux-kernel@vger.kernel.org>, Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux@sc8-sf-spam2-b.sourceforge.net, rohitseth@google.com,
       hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Pavel Emelianov <xemul@openvz.org>, devel@openvz.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
References: <44E33893.6020700@sw.ru> <44E33C3F.3010509@sw.ru>	<1155752277.22595.70.camel@galaxy.corp.google.com>	<1155755069.24077.392.camel@localhost.localdomain>	<1155756170.22595.109.camel@galaxy.corp.google.com>	<44E45D6A.8000003@sw.ru> <20060817084033.f199d4c7.akpm@osdl.org>	<20060818120809.B11407@castle.nmd.msu.ru>	<1155912348.9274.83.camel@localhost.localdomain> <20060818094248.cdca152d.akpm@osdl.org>
In-Reply-To: <20060818094248.cdca152d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I have this mad idea that you can divide a 128GB machine up into 256 fake
> NUMA nodes, then you use each "node" as a 512MB unit of memory allocation. 
> So that 4.5GB job would be placed within an exclusive cpuset which has nine
> "mems" (what are these called?) and voila: the job has a hard 4.5GB limit,
> no kernel changes needed.
this doesn't allow memory overcommitment, does it?

Kirill
