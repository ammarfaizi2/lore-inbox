Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266066AbTGIQlb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 12:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268408AbTGIQlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 12:41:31 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27825
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266066AbTGIQla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 12:41:30 -0400
Subject: Re: [PATCH] Readd BUG for SMP TLB IPI
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030709134109.65efa245.ak@suse.de>
References: <20030709124915.3d98054b.ak@suse.de>
	 <1057750022.6255.41.camel@dhcp22.swansea.linux.org.uk>
	 <20030709134109.65efa245.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057769607.6262.63.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Jul 2003 17:53:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-09 at 12:41, Andi Kleen wrote:
> > We have recorded retransmitted IPI's on some boards (notably the
> > infamous BP6). They do happen. Early 2.4 had a fix for handling the
> > replay case too, but someone lost it and BP6 boards no longer work as
> > reliably.
> 
> Ok, all non broken hardware.

It can happen to any PII/PIII box, its just very very rare on others, so
rare I guess such crashes are in the noise.

> I don't believe it. It would cause an immediate hang because the goto out
> does not ack the IPI.  Surely such hangs would have been reported?

See - trawling bug data is *useful* 8)

For 2.4.x crashes relating to IPI replay bugs are reported very occasionally, for
2.5 I've no idea at all


