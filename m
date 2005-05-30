Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVE3W0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVE3W0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 18:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVE3W0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 18:26:37 -0400
Received: from mail.dvmed.net ([216.237.124.58]:19692 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261786AbVE3W0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 18:26:34 -0400
Message-ID: <429B9311.9000608@pobox.com>
Date: Mon, 30 May 2005 18:26:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFT][PATCH] aic79xx: remove busyq
References: <20050529074620.GA26151@havoc.gtf.org> <1117488507l.7621l.0l@werewolf.able.es>
In-Reply-To: <1117488507l.7621l.0l@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> On 05.29, Jeff Garzik wrote:
> 
>>Can anyone with aic79xx hardware give me a simple "it works"
>>or "this breaks things" answer, for the patch below?
>>
>>This changes the aic79xx driver to use the standard Linux SCSI queueing
>>code, rather than its own.  After applying this patch, NO behavior
>>changes should be seen.
>>
>>The patch is against 2.6.12-rc5, but probably applies OK to recent 2.6.x
>>kernels.
>>
> 
> 
> Applied with even no offsets to -rc5-mm1. Booted and working fine:

Thanks a bunch!

	Jeff



