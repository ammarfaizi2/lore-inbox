Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUFTT1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUFTT1U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 15:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbUFTT1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 15:27:20 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:19691 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263085AbUFTT1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 15:27:18 -0400
Subject: Re: DMA API issues
From: James Bottomley <James.Bottomley@steeleye.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Ian Molton <spyro@f2s.com>, rmk+lkml@arm.linux.org.uk, david-b@pacbell.net,
       Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
In-Reply-To: <200406202002.47025.oliver@neukum.org>
References: <1087584769.2134.119.camel@mulgrave>
	<20040620165042.393f2756.spyro@f2s.com>
	<1087750024.11222.81.camel@mulgrave>  <200406202002.47025.oliver@neukum.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 20 Jun 2004 14:27:01 -0500
Message-Id: <1087759622.10858.97.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-20 at 13:02, Oliver Neukum wrote:
> > The DMA API is about allowing devices to transact directly with memory
> > behind the memory controller, it's an API that essentially allows the
> > I/O controller and memory controller to communicate without CPU
> > intervention.  This is still possible through the hypervisor, so the
> > iSeries currently fully implements the DMA API.
> 
> Then what's the problem?

If you look at the diagram, you'll see that the OHCI memory isn't behind
the memory controller...

James


