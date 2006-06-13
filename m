Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWFMTCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWFMTCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 15:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWFMTCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 15:02:12 -0400
Received: from main.gmane.org ([80.91.229.2]:29344 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750742AbWFMTCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 15:02:11 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.16-rc6-mm2
Date: Tue, 13 Jun 2006 14:01:50 -0500
Organization: IBM
Message-ID: <pan.2006.06.13.19.01.49.127376@us.ibm.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org> <pan.2006.06.12.22.09.47.855327@us.ibm.com> <20060613065443.7f302319.akpm@osdl.org> <448EC74F.30104@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 68-115-104-43.dhcp.roch.mn.charter.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006 18:10:23 +0400, Sergei Shtylyov wrote:

>     Frankly speaking, I don't see how that can be possible. I haven't touched 
> any *real* checks in ide_allocate_dma_engine(), so it should fail regardless 
> of my patch. I'd rather supposed that pci_alloc_consistent() had failed...

It appears that Sergei may be correct. I get the same failure with that
one patch reverted.

-- 

Steve Fox
IBM Linux Technology Center


