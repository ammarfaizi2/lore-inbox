Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVCJEUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVCJEUn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVCJERr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 23:17:47 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:5291 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S261172AbVCJEQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 23:16:00 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Andrew Morton <akpm@osdl.org>
Cc: kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org, axboe@suse.de
Date: Wed, 9 Mar 2005 20:15:33 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Direct io on block device has performance regression on 2.6.xkernel
In-Reply-To: <20050309201022.7302d2ac.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0503092012410.4446@qynat.qvtvafvgr.pbz>
References: <200503100347.j2A3lRg28975@unix-os.sc.intel.com><Pine.LNX.4.62.0503092000210.4446@qynat.qvtvafvgr.pbz>
 <20050309201022.7302d2ac.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005, Andrew Morton wrote:

> David Lang <dlang@digitalinsight.com> wrote:
>>
>> (I've seen a 50%
>>  performance hit on 2.4 with just a thousand or two threads compared to
>>  2.6)
>
> Was that 2.4 kernel a vendor kernel with the O(1) scheduler?

no, a kernel.org kernel. the 2.6 kernel is so much faster for this 
workload that I switched for this app and never looked back. I found that 
if I had 5000 or so idle tasks 2.4 performcane would drop to about a 
quarter of 2.6 (with the CPU system time being the limiting factor)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
