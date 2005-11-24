Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVKXPaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVKXPaO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 10:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVKXPaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 10:30:14 -0500
Received: from [81.2.110.250] ([81.2.110.250]:2281 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932129AbVKXPaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 10:30:12 -0500
Subject: Re: [patch] SMP alternatives
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <m1psoqgk18.fsf@ebiederm.dsl.xmission.com>
References: <20051123163906.GF20775@brahms.suse.de>
	 <1132766489.7268.71.camel@localhost.localdomain>
	 <20051123165923.GJ20775@brahms.suse.de>
	 <1132783243.13095.17.camel@localhost.localdomain>
	 <20051124131310.GE20775@brahms.suse.de>
	 <m1zmnugom7.fsf@ebiederm.dsl.xmission.com>
	 <20051124133907.GG20775@brahms.suse.de>
	 <1132842847.13095.105.camel@localhost.localdomain>
	 <20051124142200.GH20775@brahms.suse.de>
	 <1132845324.13095.112.camel@localhost.localdomain>
	 <20051124145518.GI20775@brahms.suse.de>
	 <m1psoqgk18.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Nov 2005 16:02:19 +0000
Message-Id: <1132848139.13095.118.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-24 at 08:09 -0700, Eric W. Biederman wrote:
> Where the EDAC code goes beyond the current k8 facilities is the
> decode to the dimm level so that the bad memory stick can be
> easily identified.

And also in finding/recording PCI parity errors (which will link nicely
into the IBM work for code to handle reported PCI errors).

