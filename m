Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268419AbTGIQwa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 12:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268438AbTGIQw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 12:52:29 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32177
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S268419AbTGIQwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 12:52:18 -0400
Subject: Re: [PATCH] Readd BUG for SMP TLB IPI
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030709185823.1f243367.ak@suse.de>
References: <20030709124915.3d98054b.ak@suse.de>
	 <1057750022.6255.41.camel@dhcp22.swansea.linux.org.uk>
	 <20030709134109.65efa245.ak@suse.de>
	 <1057769607.6262.63.camel@dhcp22.swansea.linux.org.uk>
	 <20030709185823.1f243367.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057770255.6255.70.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Jul 2003 18:04:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-09 at 17:58, Andi Kleen wrote:
> > It can happen to any PII/PIII box, its just very very rare on others, so
> > rare I guess such crashes are in the noise.
> 
> How do you know it an happen on them? Do you have backtraces?

I sat down with a BP6 owner and did lots of debugging.

> If the BUG was there they wouldn't be in the noise.  With the incomplete/broken
> handling it's just a silent hang.

I'm not arguing BUG is better than hang, but working right is better than BUG 8)

