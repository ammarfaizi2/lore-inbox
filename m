Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269162AbUIHVLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269162AbUIHVLm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 17:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269154AbUIHVLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 17:11:42 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:22208 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269153AbUIHVLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 17:11:35 -0400
Date: Wed, 08 Sep 2004 14:10:32 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Diego Calleja <diegocg@teleline.es>, Rik van Riel <riel@redhat.com>
cc: raybry@sgi.com, marcelo.tosatti@cyclades.com, kernel@kolivas.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       piggin@cyberone.com.au
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
Message-ID: <36100000.1094677832@flay>
In-Reply-To: <20040908215008.10a56e2b.diegocg@teleline.es>
References: <5860000.1094664673@flay><Pine.LNX.4.44.0409081403500.23362-100000@chimarrao.boston.redhat.com> <20040908215008.10a56e2b.diegocg@teleline.es>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > For HPC, maybe. For a fileserver, it might be far too little. That's the
>> > trouble ... it's all dependant on the workload. Personally, I'd prefer
>> > to get rid of manual tweakables (which are a pain in the ass in the field
>> > anyway), and try to have the kernel react to what the customer is doing.
>> 
>> Agreed.  Many of these things should be self-tunable pretty
>> easily, too...
> 
> I know this has been discussed before, but could a userspace daemon which
> autotunes the tweakables do a better job wrt. to adapting the kernel
> behaviour depending on the workload? Just like these days we have
> irqbalance instead of a in-kernel "irq balancer". It's a alternative
> worth of look at?

I really don't see any point in pushing the self-tuning of the kernel out
into userspace. What are you hoping to achieve?

M.


