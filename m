Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWAYH7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWAYH7V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 02:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWAYH7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 02:59:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18389 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750825AbWAYH7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 02:59:21 -0500
Date: Tue, 24 Jan 2006 23:59:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: fernando@intellilink.co.jp, ebiederm@xmission.com, vgoyal@in.ibm.com,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [PATCH 1/5] stack overflow safe kdump (2.6.16-rc1-i386) -
 safe_smp_processor_id
Message-Id: <20060124235901.719aa375.akpm@osdl.org>
In-Reply-To: <200601250853.48193.ak@suse.de>
References: <1138171868.2370.62.camel@localhost.localdomain>
	<20060124231052.7c9fcbec.akpm@osdl.org>
	<200601250853.48193.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> On Wednesday 25 January 2006 08:10, Andrew Morton wrote:
> 
> > It assumes that all x86 SMP machines have APICs.  That's untrue of Voyager.
> > I think we can probably live with this assumption - others would know
> > better than I.
> 
> Early x86s didn't have APICs and they are still often disabled on not so 
> old mobile CPUs.  I don't think it's a good assumption to make for i386.
> 

But how many of those do SMP?
