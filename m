Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbVKWWXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbVKWWXy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbVKWWXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:23:48 -0500
Received: from ns1.suse.de ([195.135.220.2]:12701 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030331AbVKWWXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:23:08 -0500
Date: Wed, 23 Nov 2005 23:23:06 +0100
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, "H. Peter Anvin" <hpa@zytor.com>,
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
Message-ID: <20051123222306.GW20775@brahms.suse.de>
References: <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <20051123211353.GR20775@brahms.suse.de> <4384E333.8030901@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4384E333.8030901@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 04:46:27PM -0500, Jeff Garzik wrote:
> Andi Kleen wrote:
> >The idea was to turn LOCK on only if the process has any
> >shared writable mapping and num_online_cpus() > 0.
> 
> Yep.  Though I presume you mean "> 1".

Yeah, > 1 of course.
-Andi
