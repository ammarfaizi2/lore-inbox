Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266865AbTBHAJE>; Fri, 7 Feb 2003 19:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbTBHAJE>; Fri, 7 Feb 2003 19:09:04 -0500
Received: from ns.suse.de ([213.95.15.193]:32780 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266865AbTBHAJE>;
	Fri, 7 Feb 2003 19:09:04 -0500
Date: Sat, 8 Feb 2003 01:18:44 +0100
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.5.59_getcycles_A0
Message-ID: <20030208001844.GA20849@wotan.suse.de>
References: <1044649542.18673.20.camel@w-jstultz2.beaverton.ibm.com.suse.lists.linux.kernel> <p73ptq3bxh6.fsf@oldwotan.suse.de> <1044659375.18676.80.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044659375.18676.80.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm sorry, I'm not seeing get_cycles used in /dev/random (although they
> do make a direct call to rdtsc if its available - which is fine, since

Hmm, perhaps it was only a proposed patch that wasn't merged.
Anyways my point stands - get_cycles should be only used when no
wall time is needed, so I see no reason to complicate it and slow
it down with external timers.

-Andi
