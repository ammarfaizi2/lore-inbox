Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266158AbUBCV2s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 16:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266161AbUBCV2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 16:28:47 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:18885 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265969AbUBCV2A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 16:28:00 -0500
Message-ID: <40201117.2040802@us.ibm.com>
Date: Tue, 03 Feb 2004 13:22:31 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Nick Piggin <piggin@cyberone.com.au>, dipankar@in.ibm.com,
       vatsa@in.ibm.com
Subject: Re: [PATCH 1/4] 2.6.2-rc2-mm2 CPU Hotplug: cpu_active_map
References: <20040131141937.EB2752C086@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> D: The semantics of this mask are as follows:
> D: 1) For platforms without hot unplug of CPUs: cpu_active_map ==
> D:    cpu_online_map.
> D: 2) For the others, they are equal except for a CPU which is going
> D:    down: cpu_online_map gets cleared by __cpu_disable(), cpu_ipi_map
> D:    gets cleared in __cpu_die() once the CPU is no longer responding
> D:    to interrupts.

Small typo, but I believe you meant to type 'cpu_active_map' in part 2, 
not 'cpu_ipi_map'.

Cheers!

-Matt

