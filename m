Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbVCCRcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVCCRcI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbVCCRbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 12:31:33 -0500
Received: from warden2-p.diginsite.com ([209.195.52.120]:19450 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262541AbVCCRaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:30:09 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Date: Thu, 3 Mar 2005 09:29:02 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: proc/locaavg definition
In-Reply-To: <20050303023650.63056ad1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0503030928480.29190@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.62.0503030100550.28740@qynat.qvtvafvgr.pbz>
 <20050303023650.63056ad1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005, Andrew Morton wrote:

> David Lang <david.lang@digitalinsight.com> wrote:
>>
>> from what I have been able to find under /Documentation /proc/loadavg is
>>  defined as giving three loadaverage numbers, 1 min, 5 min, 15 min.
>>
>>  however as of 2.6.5ish timeframe there are a coupld of additional colums
>>  that do not appear to be documented
>>
>>  the first is something #/# that could be # of running processes/total # of
>>  processes, but I can't find a definition of this anywhere
>
> 	number of currently ready-to-run threads
> 	/
> 	total number of threads in the machine
> 	the pid of the most-recently-created thread.
>
> No idea why the last one is there.

Thanks


-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
