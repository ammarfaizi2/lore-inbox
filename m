Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267469AbUG2WZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267469AbUG2WZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267490AbUG2WZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:25:27 -0400
Received: from the-village.bc.nu ([81.2.110.252]:54429 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267488AbUG2WYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:24:32 -0400
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: ebiederm@xmission.com, suparna@in.ibm.com, fastboot@osdl.org,
       mbligh@aracnet.com, jbarnes@engr.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040729111728.5d2bb5c8.akpm@osdl.org>
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
	 <1091109427.865.1.camel@localhost.localdomain>
	 <20040729111728.5d2bb5c8.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091136012.1455.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 29 Jul 2004 22:20:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-07-29 at 19:17, Andrew Morton wrote:
> Of course, there's an assumption here that the dead kernel doesn't scribble
> on pages which were never available to its page allocator.  If DMA somehow
> goes off and scribbles on the dump kernel we lose.

If the new kernel image starts with an SHA hash check including the
SHA hash check code that can be pretty robust as a sanity check.

> See above.  We assume that network RX DMA won't be scribbling in the 16MB
> which was pre-reserved.  That's reasonable.  We _have_ to assume that.

Ok

