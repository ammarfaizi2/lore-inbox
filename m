Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbTKNUEW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 15:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTKNUEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 15:04:21 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:19397 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262529AbTKNUER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 15:04:17 -0500
Date: Fri, 14 Nov 2003 12:29:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm3
Message-ID: <100480000.1068841761@flay>
In-Reply-To: <200311141110.12671.pbadari@us.ibm.com>
References: <20031112233002.436f5d0c.akpm@osdl.org> <98290000.1068836914@flay> <200311141110.12671.pbadari@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > - Several ext2 and ext3 allocator fixes.  These need serious testing on
>> > big SMP.
>> 
>> OK, ext3 survived a swatting on the 16-way as well. It's still slow as
>> snot, but it does work ;-) No changes from before, methinks.
>> 
>> Diffprofile for kernbench (-j) from ext2 to ext3 on mm3
>> 
>>      27022    16.3% total
>>      24069    53.3% default_idle
>>        583     2.4% page_remove_rmap
>>        539   248.4% fd_install
>>        478   388.6% __blk_queue_bounce
> 
> What driver are you using ? Why are you bouncing ?

qlogicisp. Because the driver is crap? ;-)

M.

