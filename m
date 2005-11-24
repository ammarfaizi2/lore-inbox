Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbVKXAzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbVKXAzY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 19:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbVKXAzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 19:55:24 -0500
Received: from mail.dvmed.net ([216.237.124.58]:19847 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932535AbVKXAzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 19:55:22 -0500
Message-ID: <43850F66.8010500@pobox.com>
Date: Wed, 23 Nov 2005 19:55:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "H. Peter Anvin" <hpa@zytor.com>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214344.GU20775@brahms.suse.de>
In-Reply-To: <20051123214344.GU20775@brahms.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Andi Kleen wrote: >>THAT is what I'd like to have CPU
	support for. Not for UP (it's going >>away), and not for the kernel
	(it's never single-threaded). > > > There is one reasonly interesting
	special case that will probably stay > around: single CPU guest in a
	virtualized environment. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>THAT is what I'd like to have CPU support for. Not for UP (it's going 
>>away), and not for the kernel (it's never single-threaded).
> 
> 
> There is one reasonly interesting special case that will probably stay
> around: single CPU guest in a virtualized environment.

There will continue to be tons of embedded uniprocessor Linux use...

It will take a while for Linux phones and watches to become multi-core.

	Jeff



