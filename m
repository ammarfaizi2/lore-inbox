Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbVI3K5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbVI3K5n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 06:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbVI3K5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 06:57:42 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:16873 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030260AbVI3K5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 06:57:42 -0400
Date: Fri, 30 Sep 2005 12:58:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc2-rt2
Message-ID: <20050930105826.GA24111@elte.hu>
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu> <1128012346.16275.71.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128012346.16275.71.camel@dyn9047017102.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Badari Pulavarty <pbadari@gmail.com> wrote:

> On Mon, 2005-09-26 at 09:02 +0200, Ingo Molnar wrote:
> > i have released the 2.6.14-rc2-rt2 tree, which can be downloaded from 
> > the usual place:
> > 
> >    http://redhat.com/~mingo/realtime-preempt/
> > 
> 
> Hi Ingo,
> 
> I noticed that you moved to "-rt7" already.
>  "-rt7" fails to compile with CONFIG_NUMA.
> 
> mm/slab.c:2404: error: conflicting types for `kmem_cache_alloc_node'
> include/linux/slab.h:122: error: previous declaration of
> `kmem_cache_alloc_node'
> 
> Here is the simple fix.

thanks, applied.

	Ingo
