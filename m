Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267612AbUJBX3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267612AbUJBX3q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 19:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267618AbUJBX3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 19:29:46 -0400
Received: from gizmo10ps.bigpond.com ([144.140.71.20]:57063 "HELO
	gizmo10ps.bigpond.com") by vger.kernel.org with SMTP
	id S267612AbUJBX3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 19:29:43 -0400
Message-ID: <415F39E3.3080406@bigpond.net.au>
Date: Sun, 03 Oct 2004 09:29:39 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>
CC: Paul Jackson <pj@sgi.com>, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com, llp@CS.Princeton.EDU
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
References: <NIBBJLJFDHPDIBEEKKLPCEFLCHAA.mef@cs.princeton.edu> <415ED4A4.1090001@watson.ibm.com> <20041002105305.2caf97ae.pj@sgi.com> <415EF069.7090902@watson.ibm.com>
In-Reply-To: <415EF069.7090902@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> 
> 
> Paul Jackson wrote:
> 
>> Hubertus wrote:
>>
>>> Marc, cpusets lead to physical isolation.
>>
>>
>>
>> This is slightly too terse for my dense brain to grok.
>> Could you elaborate just a little, Hubertus?  Thanks.
>>
> 
> A minimal quote from your website :-)
> 
> "CpuMemSets provides a new Linux kernel facility that enables system 
> services and applications to specify on which CPUs they may be 
> scheduled, and from which nodes they may allocate memory."
> 
> Since I have addressed the cpu section it seems obvious that
> in order to ISOLATE different workloads, you associate them onto
> non-overlapping cpusets, thus technically they are physically isolated
> from each other on said chosen CPUs.
> 
> Given that cpuset hierarchies translate into cpu-affinity masks,
> this desired isolation can result in lost cycles globally.

This argument if followed to its logical conclusion would advocate the 
abolition of CPU affinity masks completely.

> 
> I believe this to be orthogonal to share settings. To me both
> are extremely desirable features.
> 
> I also pointed out that if you separate mechanism from API, it
> is possible to move the CPU set API under the CKRM framework.
> I have not thought about the memory aspect.
> 
> -- Hubertus
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
