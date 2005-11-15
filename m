Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbVKOQeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbVKOQeV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbVKOQeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:34:21 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:22801 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S964856AbVKOQeU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:34:20 -0500
Message-ID: <437A0E08.103@vmware.com>
Date: Tue, 15 Nov 2005 08:34:16 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Dave Jones <davej@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
References: <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>	 <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de>	 <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de>	 <437A0649.7010702@suse.de> <437A0710.4020107@vmware.com>	 <1132070764.2822.27.camel@laptopd505.fenrus.org>	 <20051115161041.GA1749@redhat.com> <437A0965.7020909@zytor.com>	 <20051115161949.GC1749@redhat.com> <1132071933.2822.30.camel@laptopd505.fenrus.org>
In-Reply-To: <1132071933.2822.30.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2005 16:34:18.0910 (UTC) FILETIME=[6CFA3BE0:01C5EA02]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>the good news is that all hotplugable x86 cpus will have HT or dual core
>support.. so you always work in pairs of 2
>  
>

While there are good arguments for a pure SMP hardware world, there are 
good arguments in the virtualization world for virtual uniprocessors.  
No one can be sure which combination of HT / polycore / package 
isolation we will end up with, but we can be sure that legacy systems 
will be around for longer than anyone wants to think about.  As this CR4 
valid on 486s patch proves :)
