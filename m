Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266449AbUFQKuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266449AbUFQKuD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 06:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266451AbUFQKuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 06:50:03 -0400
Received: from aun.it.uu.se ([130.238.12.36]:63924 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266449AbUFQKuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 06:50:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16593.30535.933233.650450@alkaid.it.uu.se>
Date: Thu, 17 Jun 2004 12:49:43 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, peter@cordes.ca,
       len.brown@intel.com
Subject: Re: x86-64: double timer interrupts in recent 2.4.x
In-Reply-To: <20040617122645.5d1b5ec1.ak@suse.de>
References: <200406170854.i5H8s0v5012548@alkaid.it.uu.se>
	<20040617122645.5d1b5ec1.ak@suse.de>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > On Thu, 17 Jun 2004 10:54:00 +0200 (MEST)
 > Mikael Pettersson <mikpe@csd.uu.se> wrote:
 > 
 > > On Wed, 16 Jun 2004 16:28:26 -0300, Peter Cordes wrote:
 > > > I just noticed that on my Opteron cluster, the nodes that are running 64bit
 > > >kernels have their clocks ticking at double speed.  This happens with
 > > >Linux 2.4.26, and 2.4.27-pre2
 > > 
 > > I had the same problem: 2.4 x86-64 kernels ticking the clock
 > > twice its normal speed, unless I booted with pci=noacpi.
 > > 
 > > This got fixed very recently I believe, in a 2.4.27-pre kernel.
 > 
 > In which one exactly? Most likely it was an ACPI problem/fix.
 > Len, do you remember fixing such an issue?

I'm away from my K8 at the moment, but I can check this on Saturday.

/Mikael
