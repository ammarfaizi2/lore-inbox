Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030491AbVKWXL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030491AbVKWXL1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030490AbVKWXL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:11:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46762 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030491AbVKWXLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:11:25 -0500
Date: Wed, 23 Nov 2005 15:10:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
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
In-Reply-To: <20051123222212.GV20775@brahms.suse.de>
Message-ID: <Pine.LNX.4.64.0511231509550.13959@g5.osdl.org>
References: <1132764133.7268.51.camel@localhost.localdomain>
 <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain>
 <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com>
 <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain>
 <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214344.GU20775@brahms.suse.de>
 <Pine.LNX.4.64.0511231413530.13959@g5.osdl.org> <20051123222212.GV20775@brahms.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Nov 2005, Andi Kleen wrote:
> 
> I don't think it'll force them to that, it will just be a common
> use case. e.g. you start a separate VM to run your firewall in.
> Do you really need it multithreaded? 

The question is: do you need a virtualized environment for it.

And the answer is: no.

I realize that you can make up an infinite number of things you _can_ use 
virtualization for. That doesn't mean that people _will_.

		Linus
