Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267248AbTAAPo7>; Wed, 1 Jan 2003 10:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbTAAPo7>; Wed, 1 Jan 2003 10:44:59 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:21765 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267248AbTAAPo6>; Wed, 1 Jan 2003 10:44:58 -0500
Date: Wed, 1 Jan 2003 10:51:14 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix os release detection in module-init-tools-0.9.6 
In-Reply-To: <Pine.LNX.4.33L2.0212291029540.10723-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.3.96.1030101104259.14470A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Dec 2002, Randy.Dunlap wrote:

> On Sun, 29 Dec 2002, Rusty Russell wrote:

> | Um, you read the .config, which hopefully is stored somewhere.
> | (Although you could resurrect the /proc/config patch which goes around
> | every so often).  There are many things you can't tell by reading
> | /proc/ksyms.
> 
> Right, the .config file is the answer.  And there are at least 2
> patch solutions for it, the /proc/config that Rusty mentioned, or
> the in-kernel config that Khalid Aziz and others from HP did along
> with me, and it's in 2.4.recent-ac or 2.5.recent-dcl or 2.5.recent-cgl.

It would be useful to have a few global options perhaps included in /proc
(or wherever) on all kernels. By global I mean those which affect the
entire kernel, like preempt or smp, rather than driver options. We already
note 'tainted,' so this is not a totally new idea. It would seem that most
of the processor options could fall in this class, MCE, IOAPIC, etc.

If the aim is to speed stability, putting any of the "whole config"
options in and defaulted on might be a step toward that.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

