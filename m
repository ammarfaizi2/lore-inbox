Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269049AbUINSdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269049AbUINSdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269223AbUINScz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:32:55 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:63723 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269049AbUINScF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:32:05 -0400
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
From: Florin Andrei <florin@andrei.myip.org>
Reply-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040906162740.54a5d6c9.akpm@osdl.org>
References: <413CB661.6030303@sgi.com>
	 <cone.1094512172.450816.6110.502@pc.kolivas.org>
	 <20040906162740.54a5d6c9.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1095186713.6309.15.camel@stantz.corp.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Sep 2004 11:31:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-06 at 16:27, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:

> >  The change was not deliberate but there have been some other people report 
> >  significant changes in the swappiness behaviour as well (see archives). It 
> >  has usually been of the increased swapping variety lately. It has been 
> >  annoying enough to the bleeding edge desktop users for a swag of out-of-tree 
> >  hacks to start appearing (like mine).
> 
> All of which is largely wasted effort.

>From a highly-theoretical, ivory-tower perspective, maybe; i am not the
one to pass judgement.
>From a realistic, "fix it 'cause it's performing worse than MSDOS
without a disk cache" perspective, definitely not true.

I've found a situation where the vanilla kernel has a behaviour that
makes no sense:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109237941331221&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=109237959719868&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=109238126314192&w=2

A patch by Con Kolivas fixed it:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109410526607990&w=2

I cannot offer more details, i have no time for experiments, i just need
a system that works. The vanilla kernel does not.

-- 
Florin Andrei

http://florin.myip.org/

