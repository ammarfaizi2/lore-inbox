Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264635AbUGHROc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbUGHROc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 13:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUGHROc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 13:14:32 -0400
Received: from webmail.sub.ru ([213.247.139.22]:7684 "HELO techno.sub.ru")
	by vger.kernel.org with SMTP id S264635AbUGHRO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 13:14:26 -0400
Subject: Re: [ck] Re: Autoregulate swappiness & inactivation
From: Mikhail Ramendik <mr@ramendik.ru>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       nigelenki@comcast.net, linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <40ED01FF.6010206@yahoo.com.au>
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net>
	 <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org>
	 <cone.1089268800.781084.4554.502@pc.kolivas.org>
	 <40ECF278.7070606@yahoo.com.au>
	 <cone.1089270749.964538.4554.502@pc.kolivas.org>
	 <40ECF86D.3060707@yahoo.com.au>
	 <cone.1089273829.122131.4554.502@pc.kolivas.org>
	 <40ED01FF.6010206@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1089306851.2753.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-6aspMR) 
Date: Thu, 08 Jul 2004 21:14:11 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Nick Piggin wrote:

> > Umm I think we're agreeing, no? I'm trying to leave the swappiness knob 
> > in for those who (think?) they know what they're doing. Somehow it needs 
> > to be turned to "manual" again.
> No. Fold your all "autoswappiness" stuff directly into the
> reclaim_mapped calculation that was previously keyed off swappiness.
> Don't have it modify vm_swappiness at all: work directly on
> reclaim_mapped.
> 
> Then, you should be able to retain the user's vm_swappiness input
> into the system as well. If you can't figure out a good place to
> put this in, don't worry about it to start with.

I, as a user, would be far less happy without the ability to set it to
"the old way". Of course "the old" vs "the new" may become a kernel
config option, but why is a recompile better than a sysctl? Out of 
principle?

Yours, Mikhail Ramendik



