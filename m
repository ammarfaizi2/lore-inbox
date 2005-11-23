Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932551AbVKWVq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbVKWVq5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbVKWVq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:46:57 -0500
Received: from mail.dvmed.net ([216.237.124.58]:3718 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932198AbVKWVq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:46:56 -0500
Message-ID: <4384E333.8030901@pobox.com>
Date: Wed, 23 Nov 2005 16:46:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
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
References: <437B5A83.8090808@suse.de> <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <20051123211353.GR20775@brahms.suse.de>
In-Reply-To: <20051123211353.GR20775@brahms.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Andi Kleen wrote: > The idea was to turn LOCK on only
	if the process has any > shared writable mapping and num_online_cpus()
	> 0. Yep. Though I presume you mean "> 1". One hopes that
	num_online_cpus() never reaches zero during runtime ;-) [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> The idea was to turn LOCK on only if the process has any
> shared writable mapping and num_online_cpus() > 0.

Yep.  Though I presume you mean "> 1".

One hopes that num_online_cpus() never reaches zero during runtime ;-)

	Jeff


