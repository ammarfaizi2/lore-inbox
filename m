Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266497AbUA3Apw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 19:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266502AbUA3Apv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 19:45:51 -0500
Received: from ns.suse.de ([195.135.220.2]:46307 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266497AbUA3Apu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 19:45:50 -0500
Date: Fri, 30 Jan 2004 01:40:31 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: yoshfuji@linux-ipv6.org, kas@informatics.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Patch: IPv6/AMD64: bug in net/ipv6/ndisc.c
Message-Id: <20040130014031.31ec050f.ak@suse.de>
In-Reply-To: <20040129153953.3dd2cd23.davem@redhat.com>
References: <20040129221538.J24747@fi.muni.cz>
	<20040130.083743.20740540.yoshfuji@linux-ipv6.org>
	<20040129153953.3dd2cd23.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jan 2004 15:39:53 -0800
"David S. Miller" <davem@redhat.com> wrote:

> On Fri, 30 Jan 2004 08:37:43 +0900 (JST)
> YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> wrote:
> 
> > For long term solution, I think it is better to store timing variables 
> > in "unsinged long" type instead of int. 
> 
> I think this is the only fix to even consider, even in the short term.
> The macro suggested is just too much of a hack. :)
> 
> We can just ignore the silly warning until we are able to find time
> to do the correct fix.


Fine by me. I've been ignoring it forever. But don't you see it on sparc64 too?

FWIW only IPv6, keyboard driver and ACPI are spewing warnings on x86-64 in a defconfig
compile.

-Andi
