Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265125AbUFRMKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbUFRMKF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 08:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265126AbUFRMKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 08:10:04 -0400
Received: from 30.Red-80-36-33.pooles.rima-tde.net ([80.36.33.30]:35808 "EHLO
	linalco.com") by vger.kernel.org with ESMTP id S265125AbUFRMKB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 08:10:01 -0400
Date: Fri, 18 Jun 2004 14:09:42 +0200
From: Ragnar Hojland Espinosa <ragnar.hojland@linalco.com>
To: linux-kernel@vger.kernel.org
Cc: bmarsh@bmarsh.com, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Use of Moxa serial card with SMP kernels
Message-ID: <20040618120355.GA22970@linalco.com>
References: <200406171112.39485.bmarsh@bmarsh.com> <20040617084132.510d0bcb.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617084132.510d0bcb.rddunlap@osdl.org>
X-Edited-With-Muttmode: muttmail.sl - 2001-09-27
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 08:41:32AM -0700, Randy.Dunlap wrote:
> Both Moxa serial drivers (moxa & mxser) are BROKEN_ON_SMP because
> they use cli() to disable interrupts for critical sections.
> See Documentation/cli-sti-removal.txt for details.
> They will need some acceptable modern form of protection there,
> 
> Is anyone working on this?  not that I've heard of.
> Have you tried this email address:
> Copyright (C) 1999-2000  Moxa Technologies (support@moxa.com.tw).

I'd try writing and asking about it;  they were very helpful when we
had problems.
-- 
Ragnar Hojland - Project Manager
Linalco "Specialists in Linux and Free Software"
http://www.linalco.com  Tel: +34-91-4561700
