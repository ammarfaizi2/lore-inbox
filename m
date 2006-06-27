Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161158AbWF0QV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbWF0QV2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161157AbWF0QV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:21:28 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28292 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161153AbWF0QV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:21:27 -0400
Subject: Re: Areca driver recap + status
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Robert Mueller <robm@fastmail.fm>, Andrew Morton <akpm@osdl.org>,
       rdunlap@xenotime.net, hch@infradead.org, erich@areca.com.tw,
       brong@fastmail.fm, dax@gurulabs.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <1151422767.3340.29.camel@mulgrave.il.steeleye.com>
References: <09be01c695b3$2ed8c2c0$c100a8c0@robm>
	 <20060621222826.ff080422.akpm@osdl.org>
	 <1151333338.2673.4.camel@mulgrave.il.steeleye.com>
	 <057801c69970$70b45090$0e00cb0a@robm>
	 <1151422074.3340.25.camel@mulgrave.il.steeleye.com>
	 <1151423500.32186.39.camel@localhost.localdomain>
	 <1151422767.3340.29.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Jun 2006 17:36:59 +0100
Message-Id: <1151426219.32186.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-06-27 am 10:39 -0500, ysgrifennodd James Bottomley:
> On Tue, 2006-06-27 at 16:51 +0100, Alan Cox wrote:
> > On x86_64 the dma_addr_t and the ulong are both 64bit so the problem
> > doesn't arise. 
> 
> Yes it does ... apparently 32 bit kernel on x86_64 is a lot more common
> than people suppose.  In > 4GB this is exactly PAE.

In your original mail you stated

"It probably is only significant on x86_64 with the gart iommu enabled."

IOMMU is only in the 64bit kernel that I can see.

