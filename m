Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWFRQQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWFRQQR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 12:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWFRQQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 12:16:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:53734 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932234AbWFRQQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 12:16:17 -0400
Message-ID: <1364850.1150647367930.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Date: Sun, 18 Jun 2006 18:16:07 +0200 (CEST)
From: Andreas Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.16-rc6-mm2] x86: add NUMA to oops messages
Cc: Arjan van de Ven <arjan@linux.intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200606180815_MC3-1-C2CC-41A5@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3 (normal)
X-Mailer: SuSE Linux Openexchange Server 4 - WebMail (Build 2.4160)
X-Operating-System: Linux 2.4.21-309-smp i386 (JVM 1.3.1_18)
Organization: SuSE Linux AG
References: <200606180815_MC3-1-C2CC-41A5@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am So 18.06.2006 14:13 schrieb Chuck Ebbert <76306.1226@compuserve.com>:

> In-Reply-To: <200606181059.44576.ak@suse.de>
>
> On Sun, 18 Jun 2006 10:59:44 +0200, Andi Kleen wrote:
>
> > On Sunday 18 June 2006 10:13, Chuck Ebbert wrote:
> > > Add "NUMA" to x86 oops printouts to help with debugging. Use
> > > vermagic.h
> > > defines to clean up the code, suggested by Arjan van de Ven.
> >
> > I don't see any particular value in printing NUMA here,
>
> It helps a lot when trying to decode oopses posted to the list, as the
> NUMA kernel is very different now that the slab allocator and
> scheduler
> are NUMA-aware.

And there are a thousand other things that change with other
CONFIG_* options. I also can't remember a bug where
this wasn't clear.

In general the rule of thumb is: i386: NUMA is not
used and x86-64 SMP: NUMA is used.

-Andi


