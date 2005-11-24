Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbVKXTK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbVKXTK2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 14:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbVKXTK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 14:10:28 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:43424 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1751386AbVKXTK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 14:10:27 -0500
Date: Thu, 24 Nov 2005 11:12:07 -0800
From: thockin@hockin.org
To: Andi Kleen <ak@suse.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Gerd Knorr <kraxel@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051124191207.GB2468@hockin.org>
References: <1132783243.13095.17.camel@localhost.localdomain> <20051124131310.GE20775@brahms.suse.de> <m1zmnugom7.fsf@ebiederm.dsl.xmission.com> <20051124133907.GG20775@brahms.suse.de> <1132842847.13095.105.camel@localhost.localdomain> <20051124142200.GH20775@brahms.suse.de> <1132845324.13095.112.camel@localhost.localdomain> <20051124145518.GI20775@brahms.suse.de> <m1psoqgk18.fsf@ebiederm.dsl.xmission.com> <20051124153635.GJ20775@brahms.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051124153635.GJ20775@brahms.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 04:36:35PM +0100, Andi Kleen wrote:
> > The current k8
> > code has been delayed for this reason.
> > 
> > Where the EDAC code goes beyond the current k8 facilities is the
> > decode to the dimm level so that the bad memory stick can be
> > easily identified.
> 
> That would be nice to have agreed. But I don't really know
> how to do this without mainboard specific knowledge.
> If you have something usable it's best to port it to mce.c
> or perhaps mcelog

I'm curious about that too.  Even with k8 you can get down to a
chip-select, but that doesn't necessarily map to a DIMM in any useful way,
unless you have some mobo knowledge.  Are we going to need a new BIOS
table to map chip-selects onto DIMMs? :)

