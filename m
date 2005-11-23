Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030435AbVKWWjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbVKWWjA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbVKWWhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:37:14 -0500
Received: from terminus.zytor.com ([192.83.249.54]:20663 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030444AbVKWWhI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:37:08 -0500
Message-ID: <4384EEE9.3080809@zytor.com>
Date: Wed, 23 Nov 2005 14:36:25 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214344.GU20775@brahms.suse.de> <Pine.LNX.4.64.0511231413530.13959@g5.osdl.org> <20051123222212.GV20775@brahms.suse.de> <4384EC68.1060302@zytor.com> <20051123223253.GX20775@brahms.suse.de>
In-Reply-To: <20051123223253.GX20775@brahms.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>Well, with VTX or Pacifica virtualization is in ring 3.  The fact that 
> 
> Not it's not. The whole point is that there is no "ring compression" 
> The guest has all its normal rings, just the hypervisor has additional
> "negative" rings.
> 

Uhm... maybe we think of it differently, but typically I consider the 
host rings (which is what I talked about above) as orthogonal to the 
guest ring.  To the host, the guest is just a process in ring 3.

	-hpa
