Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVGUNi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVGUNi6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 09:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVGUNi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 09:38:57 -0400
Received: from leyde.iplannetworks.net ([200.69.193.99]:52419 "EHLO
	proxy3.iplannetworks.net") by vger.kernel.org with ESMTP
	id S261776AbVGUNi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 09:38:57 -0400
Message-ID: <42DFA5E6.1080302@latinsourcetech.com>
Date: Thu, 21 Jul 2005 10:40:54 -0300
From: =?ISO-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@latinsourcetech.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Horman <nhorman@redhat.com>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Memory Management
References: <42DF9646.5070806@latinsourcetech.com> <20050721131132.GB11327@hmsendeavour.rdu.redhat.com>
In-Reply-To: <20050721131132.GB11327@hmsendeavour.rdu.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>http://people.redhat.com/nhorman/papers/rhel3_vm.pdf
>I wrote this with norm awhile back.  It may help you out.
>Regards
>Neil
>  
>
Neil,

   Thanks.~10-12GB of total RAM (16GB) are

   How can Proc virtual memory parameters like inactive_clean_percent, 
overcommit_memory, overcommit_ratio and page_cache help me to solve / 
reduce Out Of Memory conditions on servers with 16GB RAM and lots of GB 
swap?

   Kernel does not free cached memory (~10-12GB of total RAM - 16GB). Is 
there some way to force the kernel to free cached memory?

/proc/meminfo:

              total:    used:    free:  shared: buffers:  cached:
Mem:    16603488256 16523333632 80154624        0 70651904 13194563584
Swap:   17174257664 11771904 17162485760
MemTotal:     16214344 kB
MemFree:         78276 kB
Buffers:         68996 kB
Cached:       12874808 kB

Thanks to all.

Marcio.


