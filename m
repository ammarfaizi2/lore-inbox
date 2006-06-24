Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWFXHgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWFXHgb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 03:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933209AbWFXHgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 03:36:31 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:57833 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932227AbWFXHga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 03:36:30 -0400
Message-ID: <449CEB7C.3060004@watson.ibm.com>
Date: Sat, 24 Jun 2006 03:36:28 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jlan@sgi.com, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Revised locking for taskstats interface
References: <449C2A44.9000206@watson.ibm.com> <20060623233245.77f365bb.akpm@osdl.org>
In-Reply-To: <20060623233245.77f365bb.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Fri, 23 Jun 2006 13:52:04 -0400
>Shailabh Nagar <nagar@watson.ibm.com> wrote:
>
>  
>
>>Convert locking used within taskstats interface and delay accounting
>>code to be more fine-grained.
>>    
>>
>
>This patch is based on
>per-task-delay-accounting-taskstats-interface-fix-exit-race-in-per-task-delay-accounting.patch,
>which I've noted as `nacked' but didn't drop.
>
>So I guess that's now un-nacked?
>  
>
Not in intent. This patch reverses all the changes made by that patch. 
So effectively the previous patch is still nacked.
However, I based this patch on the previous one because you hadn't 
dropped the latter (so we're going round in circles !)

How about  I just send one patch that covers the whole locking thing ?

--Shailabh
