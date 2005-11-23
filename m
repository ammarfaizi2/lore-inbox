Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030441AbVKWWk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbVKWWk4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbVKWWky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:40:54 -0500
Received: from cantor2.suse.de ([195.135.220.15]:52644 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030441AbVKWWkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:40:19 -0500
Date: Wed, 23 Nov 2005 23:40:09 +0100
From: Andi Kleen <ak@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051123224009.GY20775@brahms.suse.de>
References: <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214344.GU20775@brahms.suse.de> <Pine.LNX.4.64.0511231413530.13959@g5.osdl.org> <20051123222212.GV20775@brahms.suse.de> <4384EC68.1060302@zytor.com> <20051123223253.GX20775@brahms.suse.de> <4384EEE9.3080809@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4384EEE9.3080809@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Uhm... maybe we think of it differently, but typically I consider the 
> host rings (which is what I talked about above) as orthogonal to the 
> guest ring.  To the host, the guest is just a process in ring 3.

I don't think your thoughts match the terminology as used by Intel/AMD/Xen
at least.

-Andi
