Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267327AbUG1X6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267327AbUG1X6O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267344AbUG1X6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 19:58:14 -0400
Received: from the-village.bc.nu ([81.2.110.252]:39323 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267327AbUG1X6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 19:58:11 -0400
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com, fastboot@osdl.org,
       mbligh@aracnet.com, jbarnes@engr.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m1llh367s4.fsf@ebiederm.dsl.xmission.com>
References: <16734.1090513167@ocs3.ocs.com.au>
	 <20040725235705.57b804cc.akpm@osdl.org>
	 <m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	 <200407280903.37860.jbarnes@engr.sgi.com> <25870000.1091042619@flay>
	 <m14qnr7u7b.fsf@ebiederm.dsl.xmission.com>
	 <20040728133337.06eb0fca.akpm@osdl.org>
	 <1091044742.31698.3.camel@localhost.localdomain>
	 <m1llh367s4.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091055311.31923.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 28 Jul 2004 23:55:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-07-29 at 00:17, Eric W. Biederman wrote:
> What is your concern with stopping DMA?
> - Not smashing the recovery routine.
> - Getting a corrupted core dump because of on-going DMA?

Completely random happenings occurring when they are trivial to avoid.
Given all the worries about SHA signed in kernel standalone objects I
find it farcical that the same people don't even care about ensuring
something isnt DMAing over their dump partition description.

Alan

