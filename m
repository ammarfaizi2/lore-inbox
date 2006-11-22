Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756475AbWKVSr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756475AbWKVSr7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756473AbWKVSr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:47:59 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41100 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1756472AbWKVSr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:47:58 -0500
Date: Wed, 22 Nov 2006 10:42:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>, gregkh@suse.de,
       Ingo Molnar <mingo@redhat.com>, Len Brown <len.brown@intel.com>,
       phil.el@wanadoo.fr, oprofile-list@lists.sourceforge.net
Subject: Re: 2.6.19-rc5: known regressions (v3)
Message-Id: <20061122104245.3ce89487.akpm@osdl.org>
In-Reply-To: <200611221136.14565.ak@suse.de>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<200611151135.48306.dada1@cosmosbay.com>
	<200611221128.05769.dada1@cosmosbay.com>
	<200611221136.14565.ak@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006 11:36:14 +0100
Andi Kleen <ak@suse.de> wrote:

> On Wednesday 22 November 2006 11:28, Eric Dumazet wrote:
> > On Wednesday 15 November 2006 11:35, Eric Dumazet wrote:
> > > On Wednesday 15 November 2006 11:21, Adrian Bunk wrote:
> > > > Subject    : x86_64: oprofile doesn't work
> > > > References : http://lkml.org/lkml/2006/10/27/3
> > > > Submitter  : Prakash Punnoor <prakash@punnoor.de>
> > > > Status     : unknown
> > >
> > 
> > I hit the same problem on i386 architecture too, if CONFIG_ACPI is not set.
> 
> oprofile is still broken because it cannot deal with the lack of perfctr 0.

The kernel is still broken because we changed the interface.

> You can disable the nmi watchdog as a workaround.

I don't understand why you think this is acceptable.
