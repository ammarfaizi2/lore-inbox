Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUDSURn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 16:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUDSURn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 16:17:43 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:26051 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262029AbUDSUQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 16:16:35 -0400
Date: Mon, 19 Apr 2004 16:16:58 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Willy Tarreau <w@w.ods.org>
Cc: Joe Korty <joe.korty@ccur.com>, cramerj@intel.com, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] e1000 fails on 2.4.26+bk with CONFIG_SMP=y
In-Reply-To: <20040419193930.GA28340@alpha.home.local>
Message-ID: <Pine.LNX.4.58.0404191615560.2252@montezuma.fsmlabs.com>
References: <20040416224422.GA19095@tsunami.ccur.com> <20040417072455.GD596@alpha.home.local>
 <20040419165425.GA3988@tsunami.ccur.com> <20040419193930.GA28340@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004, Willy Tarreau wrote:

> Hi Joe,
>
> On Mon, Apr 19, 2004 at 12:54:25PM -0400, Joe Korty wrote:
> >
> > Uniprocessor 2.4.26 works fine.
> > Uniprocessor 2.4.26 + local apic works fine.
> > Uniprocessor 2.4.26 + local apic + io apic fails.
>
> interesting. Unfortunately, I didn't have time to try on the machine I told
> you about last day. But right here, I have a dual athlon communicating with
> an alpha, both with e1000 (544) in 2.4.26. Since there's a PCI bridge on your
> quad, I wonder if the IOAPIC doesn't trigger an interrupt routing problem with
> bridges. Are all the ports unusable or do some of them work reliably in APIC
> mode ?

Joe could you also try it without ACPI if possible.
