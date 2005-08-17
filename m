Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbVHQTQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVHQTQZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 15:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbVHQTQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 15:16:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40942 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751213AbVHQTQY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 15:16:24 -0400
Message-ID: <43038CF1.6020608@mvista.com>
Date: Wed, 17 Aug 2005 12:16:01 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] KGDB for Real-Time Preemption systems
References: <20050811110051.GA20872@elte.hu> <43028A94.1050603@mvista.com> <20050817065340.GA9148@elte.hu>
In-Reply-To: <20050817065340.GA9148@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * George Anzinger <george@mvista.com> wrote:
> 
> 
>>I have put a version of KGDB for x86 RT kernels here:
>>http://source.mvista.com/~ganzinger/
>>
>>The common_kgdb_cfi_.... stuff creates debug records for entry.S and 
>>friends so that you can "bt" through them.  Apply in this order: 
>>Ingo's patch kgdb-ga-rt.patch common_kgdb_cfi_annotations.patch
>>
>>This is, more or less, the same kgdb that is in Andrew's mm tree 
>>changed to fix the RT issues.
> 
> 
> great. For the time being i wont add it to the -RT tree (because KGDB is 
> not destined for upstream merging it seems), but it sure is a useful 
> development/debugging add-on.

I agree on not adding it.  Tom Rini is working on a version the Andrew 
seems inclined to merge.  When that happens I will most likely put 
together enhancements to it to bring it up to what this one does. 
Meanwhile I am trying to capture some of Tom's changes in this one. 
Also, it is MUCH easier for me to maintain as a seperate patch.


-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
