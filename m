Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030427AbVKWWb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbVKWWb7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbVKWWb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:31:59 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9608 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030427AbVKWWb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:31:58 -0500
Date: Wed, 23 Nov 2005 23:30:06 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051123223006.GD24220@elf.ucw.cz>
References: <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <20051123211353.GR20775@brahms.suse.de> <4384E333.8030901@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4384E333.8030901@pobox.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> >The idea was to turn LOCK on only if the process has any
> >shared writable mapping and num_online_cpus() > 0.
> 
> Yep.  Though I presume you mean "> 1".
> 
> One hopes that num_online_cpus() never reaches zero during runtime ;-)

Actually num_online_cpus() is very usefull -- suspend to RAM ;-))))).

								Pavel
-- 
Thanks, Sharp!
