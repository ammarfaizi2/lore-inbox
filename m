Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbUDEDiC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 23:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUDEDiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 23:38:02 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:35476 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263084AbUDEDh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 23:37:59 -0400
Date: Mon, 5 Apr 2004 14:39:55 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-aio@kvack.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: AIO patches reworked against radix-tree-writeback changes
Message-ID: <20040405090955.GB3402@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20040402192937.GA4900@in.ibm.com> <20040402153148.A3767@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402153148.A3767@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 03:31:48PM +0100, Christoph Hellwig wrote:
> On Sat, Apr 03, 2004 at 12:59:37AM +0530, Suparna Bhattacharya wrote:
> > I just uploaded an update to the AIO patchset against the
> > -mm tree (2.6.5-rc3-mm4):
> > www.kernel.org/pub/linux/kernel/people/suparna/aio/265rc3mm4
> 
> Why is 4g4g-aio-hang-fix.patch still only in your patchkit?  Despite the
> name it's not specific to the 4G/4G patch for x86 but nessecary for all
> architectures that have a kernel mapping unrelated to the user one (
> sparc64 and s390 come to mind).

I guess it must be because aio_kick_handler() isn't actually used in 
the mainline tree as yet, but is used by the retry-based AIO patches 
(Similarly so for some of the use_mm fixes that are part of 
aio-retry.patch).

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

