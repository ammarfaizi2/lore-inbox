Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317338AbSFRGVs>; Tue, 18 Jun 2002 02:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317339AbSFRGVr>; Tue, 18 Jun 2002 02:21:47 -0400
Received: from ns.suse.de ([213.95.15.193]:27152 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317338AbSFRGVq>;
	Tue, 18 Jun 2002 02:21:46 -0400
Date: Tue, 18 Jun 2002 08:21:34 +0200
From: Andi Kleen <ak@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk, bjornw@axis.com,
       davidm@hpl.hp.com, paulus@samba.org, anton@samba.org,
       engebret@us.ibm.com, jes@trained-monkey.org, ralf@gnu.org,
       schwidefsky@de.ibm.com, davem@redhat.com, gniibe@m17n.org, ak@suse.de
Subject: Re: [PATCH] Consolidate include/asm/signal.h
Message-ID: <20020618082134.A8287@wotan.suse.de>
References: <20020618154726.1c78f6d1.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020618154726.1c78f6d1.sfr@canb.auug.org.au>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 03:47:26PM +1000, Stephen Rothwell wrote:
> Have I gone too far this time? :-)

Looks fine.

> 
> This patch consolidates most of the common signal.h stuff between
> architectures into include/asm-generic/signal.h.  It builds fine
> on i386, but may have broken all the other architectures despite
> being careful.
> 
> Please test (at least a build).

builds on x86-64.

-andi
