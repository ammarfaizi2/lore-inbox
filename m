Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268609AbUI3JpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268609AbUI3JpN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 05:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268658AbUI3JpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 05:45:13 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:59009 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268609AbUI3JpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 05:45:09 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2: Kernel BUG at slab:2139 on dual AMD64
Date: Thu, 30 Sep 2004 11:47:29 +0200
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
References: <200409300007.29986.rjw@sisk.pl> <20040929220709.GD26714@wotan.suse.de>
In-Reply-To: <20040929220709.GD26714@wotan.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409301147.29909.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 of September 2004 00:07, Andi Kleen wrote:
> On Thu, Sep 30, 2004 at 12:07:29AM +0200, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > I've obtained the following trace on a dual-Opteron box:
> 
> Someone corrupted memory. 
> You could enable slab debugging, maybe that will find it earlier.

It's there (ie CONFIG_DEBUG_SLAB=y), please look at the .config 
(http://www.sisk.pl/kernel/040929/2.6.9-rc2.config).

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
