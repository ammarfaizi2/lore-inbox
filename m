Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbUB0OdI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 09:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbUB0OdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 09:33:08 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:24080 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261715AbUB0OdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 09:33:04 -0500
Message-ID: <403F5795.6060807@techsource.com>
Date: Fri, 27 Feb 2004 09:43:33 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Scott Robert Ladd <coyote@coyotegulch.com>
CC: "Nakajima, Jun" <jun.nakajima@intel.com>, richard.brunner@amd.com,
       linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD64
References: <7F740D512C7C1046AB53446D37200173EA28A5@scsmsx402.sc.intel.com> <403E4681.20603@techsource.com> <403E4CDF.3030300@coyotegulch.com>
In-Reply-To: <403E4CDF.3030300@coyotegulch.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Scott Robert Ladd wrote:
> Timothy Miller wrote:
> 
>> In other words, Intel's implementation deviates from the architecture 
>> as defined by AMD.  So it's not 100% compatible.  I just want this 
>> point to be clear.
> 
> 
> There may exist non-instruction-set differences between the chips as 
> well. Opteron systems (which have per-CPU memory control) operate as 
> NUMA machines; will the same be true for any of Intel's ia32e chips?
> 

Any difference which is transparent to software is irrelevant.  Hardware 
differences which can be dealt with and hidden by the kernel are things 
Linux can just deal with.  The only thing that really matters here is 
user space.

People don't seem to have problems compiling kernels for specific 
processors, and the kernel can be designed to also do run-time detection 
for the generic case (i.e. boot CD's, etc.).

