Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264320AbTKNVdM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 16:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbTKNVdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 16:33:12 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:46061 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264320AbTKNVdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 16:33:11 -0500
Date: Fri, 14 Nov 2003 13:57:53 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm3
Message-ID: <103290000.1068847073@flay>
In-Reply-To: <Pine.LNX.4.53.0311141555130.27998@montezuma.fsmlabs.com>
References: <20031112233002.436f5d0c.akpm@osdl.org> <3210000.1068786449@[10.10.2.4]> <Pine.LNX.4.53.0311141555130.27998@montezuma.fsmlabs.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > - Several ext2 and ext3 allocator fixes.  These need serious testing on big
>> >   SMP.
>> 
>> Survives kernbench and SDET on ext2 at least on 16-way. I'll try ext3
>> later.
> 
> It's actually triple faulting my laptop (K6 family=5 model=8 step=12) when 
> i have CONFIG_X86_4G enabled and try and run X11. The same kernel is fine 
> on all my other test boxes. Any hints?

Linus had some debug thing for triple faults, a few months ago, IIRC ...
probably in the archives somewhere ...

M.

