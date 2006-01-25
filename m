Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWAYJlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWAYJlp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 04:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWAYJlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 04:41:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:18400 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750941AbWAYJlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 04:41:44 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/5] stack overflow safe kdump (2.6.16-rc1-i386) - safe_smp_processor_id
Date: Wed, 25 Jan 2006 10:41:43 +0100
User-Agent: KMail/1.8
Cc: fernando@intellilink.co.jp, ebiederm@xmission.com, vgoyal@in.ibm.com,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
References: <1138171868.2370.62.camel@localhost.localdomain> <200601250853.48193.ak@suse.de> <20060124235901.719aa375.akpm@osdl.org>
In-Reply-To: <20060124235901.719aa375.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601251041.43349.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 January 2006 08:59, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> > On Wednesday 25 January 2006 08:10, Andrew Morton wrote:
> > > It assumes that all x86 SMP machines have APICs.  That's untrue of
> > > Voyager. I think we can probably live with this assumption - others
> > > would know better than I.
> >
> > Early x86s didn't have APICs and they are still often disabled on not so
> > old mobile CPUs.  I don't think it's a good assumption to make for i386.
>
> But how many of those do SMP?

The SMP kernel should still run on those. Even x86-64 had special code
for this.

-Andi

