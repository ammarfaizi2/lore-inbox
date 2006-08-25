Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWHYNeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWHYNeN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 09:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWHYNeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 09:34:13 -0400
Received: from mga05.intel.com ([192.55.52.89]:64149 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750762AbWHYNeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 09:34:12 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,168,1154934000"; 
   d="scan'208"; a="121119443:sNHT32093264"
Message-ID: <44EEFC49.3010501@linux.intel.com>
Date: Fri, 25 Aug 2006 15:34:01 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: linux-kernel@vger.kernel.org, len.brown@intel.com, mingo@elte.hu,
       akpm@osdl.org, jbarnes@virtuousgeek.org, dwalker@mvista.com,
       nickpiggin@yahoo.com.au
Subject: Re: [RFC] maximum latency tracking infrastructure (version 2)
References: <1156504939.3032.26.camel@laptopd505.fenrus.org> <20060825133034.GC5205@martell.zuzino.mipt.ru>
In-Reply-To: <20060825133034.GC5205@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> 
>> --- linux-2.6.18-rc4-latency.orig/kernel/Makefile
>> +++ linux-2.6.18-rc4-latency/kernel/Makefile
>> @@ -8,7 +8,7 @@ obj-y     = sched.o fork.o exec_domain.o
>>  	    signal.o sys.o kmod.o workqueue.o pid.o \
>>  	    rcupdate.o extable.o params.o posix-timers.o \
>>  	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o \
>> -	    hrtimer.o rwsem.o
>> +	    hrtimer.o rwsem.o latency.o
> 
> CONFIG_PM=n users aren't interested, right?

unknown for now; I've heard some rumbling about using this for more than just pure powermanagement...
