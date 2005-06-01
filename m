Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVFAS7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVFAS7L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFASzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:55:39 -0400
Received: from mail.tmr.com ([64.65.253.246]:45445 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261250AbVFASyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:54:24 -0400
Message-ID: <429E0843.5060505@tmr.com>
Date: Wed, 01 Jun 2005 15:10:59 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Swap maximum size documented ?
References: <200506011225.j51CPDV23243@lastovo.hermes.si> <20050601124025.GZ422@unthought.net> <1117630718.6271.31.camel@laptopd505.fenrus.org> <loom.20050601T150142-941@post.gmane.org> <20050601134022.GM20782@holomorphy.com>
In-Reply-To: <20050601134022.GM20782@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Wed, Jun 01, 2005 at 01:02:13PM +0000, David Bala??ic wrote:
> 
>>OK, so can anyone tell the actual, current limits ?
> 
> 
> Without CONFIG_HIGHMEM64G=y you have:
> 32 swapfiles, max swapfile size of 64GB.
> 
> With CONFIG_HIGHMEM64G=y you have:
> 32 swapfiles, max swapfile size of 512GB.

Does this apply to mmap as well? I have an application which currently 
uses 9TB of data, and one thought to boost performance was to mmap the 
data. Unfortunately, I know 16TB isn't going to be enough for more than 
a few more years :-(
-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
