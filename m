Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268180AbUG2PVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268180AbUG2PVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268170AbUG2PTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:19:41 -0400
Received: from the-village.bc.nu ([81.2.110.252]:2716 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264833AbUG2PAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 11:00:25 -0400
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: ebiederm@xmission.com, suparna@in.ibm.com, fastboot@osdl.org,
       mbligh@aracnet.com, jbarnes@engr.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040728172204.2ecc5cdd.akpm@osdl.org>
References: <16734.1090513167@ocs3.ocs.com.au>
	 <20040725235705.57b804cc.akpm@osdl.org>
	 <m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	 <200407280903.37860.jbarnes@engr.sgi.com> <25870000.1091042619@flay>
	 <m14qnr7u7b.fsf@ebiederm.dsl.xmission.com>
	 <20040728133337.06eb0fca.akpm@osdl.org>
	 <1091044742.31698.3.camel@localhost.localdomain>
	 <m1llh367s4.fsf@ebiederm.dsl.xmission.com>
	 <1091055311.31923.3.camel@localhost.localdomain>
	 <20040728172204.2ecc5cdd.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091109427.865.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 29 Jul 2004 14:57:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-07-29 at 01:22, Andrew Morton wrote:
> eh?  People do care.  The point here is that we should stop the DMA in the
> dump kernel, not from within the broken kernel.

And pray just how do you expect to prove that the dump kernel isnt
being overwritten *as* it is being loaded.

> btw, if we simply insert a five-second-pause, what problems does that
> leave?  Network Rx, which is OK.  Disk writes will have completed (?). 
> What remains?

Network RX is the obvious one since we've no idea where the DMA is
going in memory.

