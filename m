Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbUCSPKQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 10:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbUCSPKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 10:10:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19387 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263007AbUCSPKM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 10:10:12 -0500
Message-ID: <405B0D44.9070902@pobox.com>
Date: Fri, 19 Mar 2004 10:09:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark <mark@harddata.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFT] latest libata (includes Silicon Image work)
References: <4059EBB8.4010807@pobox.com> <200403181628.33558.mark@harddata.com>
In-Reply-To: <200403181628.33558.mark@harddata.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark wrote:
> On March 18, 2004 11:34 am, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Attached is the latest libata patch against 2.6.x mainline.  Although
>>not 100% of content, most of this patch resolves around getting Silicon
>>Image into better shape.  As I mentioned in my last post, this patch
>>affects all libata users, so plenty of testing is requested.
>>
> 
> Jeff,
> 
> After applying this to and rebuilding arjanv newest redhat kernel 
> (2.6.4-1.275), sd_mod doesn't load when at sata_sil is loaded. It did before 
> I patched the kernel rpm.


That's a configuration problem of some sort...  libata doesn't change 
any of that.

	Jeff



