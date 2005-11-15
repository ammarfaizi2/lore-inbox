Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbVKOQaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbVKOQaP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbVKOQaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:30:15 -0500
Received: from terminus.zytor.com ([192.83.249.54]:39810 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964880AbVKOQaN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:30:13 -0500
Message-ID: <437A0CBA.3050302@zytor.com>
Date: Tue, 15 Nov 2005 08:28:42 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Arjan van de Ven <arjan@infradead.org>, Zachary Amsden <zach@vmware.com>,
       Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
References: <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de> <437A0649.7010702@suse.de> <437A0710.4020107@vmware.com> <1132070764.2822.27.camel@laptopd505.fenrus.org> <20051115161041.GA1749@redhat.com> <437A0965.7020909@zytor.com> <20051115161949.GC1749@redhat.com>
In-Reply-To: <20051115161949.GC1749@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
>  > 
>  > If you have CPU hotplug enabled, you can run SMP code!
> 
> Sure, but if you boot with 1 CPU, spinlocks get nop'd to emulate UP,
> and on a 'installed a new cpu' hotplug event, they all come back.
> 

The point that you don't nop if you have hotplug enabled (which is not 
the norm.)

	-hpa
