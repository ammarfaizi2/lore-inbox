Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266446AbUFQK05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266446AbUFQK05 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 06:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266447AbUFQK05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 06:26:57 -0400
Received: from cantor.suse.de ([195.135.220.2]:26265 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266446AbUFQK04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 06:26:56 -0400
Date: Thu, 17 Jun 2004 12:26:45 +0200
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, peter@cordes.ca,
       len.brown@intel.com
Subject: Re: x86-64: double timer interrupts in recent 2.4.x
Message-Id: <20040617122645.5d1b5ec1.ak@suse.de>
In-Reply-To: <200406170854.i5H8s0v5012548@alkaid.it.uu.se>
References: <200406170854.i5H8s0v5012548@alkaid.it.uu.se>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004 10:54:00 +0200 (MEST)
Mikael Pettersson <mikpe@csd.uu.se> wrote:

> On Wed, 16 Jun 2004 16:28:26 -0300, Peter Cordes wrote:
> > I just noticed that on my Opteron cluster, the nodes that are running 64bit
> >kernels have their clocks ticking at double speed.  This happens with
> >Linux 2.4.26, and 2.4.27-pre2
> 
> I had the same problem: 2.4 x86-64 kernels ticking the clock
> twice its normal speed, unless I booted with pci=noacpi.
> 
> This got fixed very recently I believe, in a 2.4.27-pre kernel.

In which one exactly? Most likely it was an ACPI problem/fix.
Len, do you remember fixing such an issue?

-Andi
