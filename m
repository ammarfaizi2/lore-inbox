Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbVHYVjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbVHYVjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 17:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVHYVjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 17:39:13 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:38290 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S964848AbVHYVjL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 17:39:11 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andi Kleen <ak@suse.de>
Subject: Re: Memory problem w/ recent kernels on 2x Opteron with 12 GB RAM
Date: Thu, 25 Aug 2005 23:39:18 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, discuss@x86-64.org
References: <200508242308.55433.rjw@sisk.pl> <200508242321.48367.ak@suse.de>
In-Reply-To: <200508242321.48367.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508252339.19331.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 24 of August 2005 23:21, Andi Kleen wrote:
> On Wednesday 24 August 2005 23:08, Rafael J. Wysocki wrote:
> > Hi,
> >
> > I'm currently seeing a memory problem on a NUMA-enabled dual-Opteron 250
> > box with the 2.6.12.5 and 2.6.13-rc* (up to 7) kernels.  Namely, the box
> > has 12 GB of RAM, 8 GB of which is installed on the first node.  The whole
> > memory is detected but then only the first 8 GB of it is made available
> > (minus some hardware-related holes), as though the memory on the second
> > node were discarded for some reason.
> 
> 
> Boot log please?

Sorry for the delay.  The BIOS upgrade has fixed the problem.

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
