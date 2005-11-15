Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbVKOQQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbVKOQQL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVKOQQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:16:10 -0500
Received: from terminus.zytor.com ([192.83.249.54]:56450 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751443AbVKOQQJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:16:09 -0500
Message-ID: <437A0965.7020909@zytor.com>
Date: Tue, 15 Nov 2005 08:14:29 -0800
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
References: <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org> <20051113074241.GA29796@redhat.com> <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de> <437A0649.7010702@suse.de> <437A0710.4020107@vmware.com> <1132070764.2822.27.camel@laptopd505.fenrus.org> <20051115161041.GA1749@redhat.com>
In-Reply-To: <20051115161041.GA1749@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Tue, Nov 15, 2005 at 05:06:03PM +0100, Arjan van de Ven wrote:
>  
>  > > You still need to preserve the originals so that you can patch in both 
>  > > directions.  
>  > 
>  > why do you insist on both directions? That still sounds like real
>  > overkill to me.
> 
> cpu hotplug going from UP to SMP ? :)
> 

If you have CPU hotplug enabled, you can run SMP code!

	-hpa
