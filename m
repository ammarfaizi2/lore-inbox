Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbTBTPRY>; Thu, 20 Feb 2003 10:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbTBTPRY>; Thu, 20 Feb 2003 10:17:24 -0500
Received: from havoc.daloft.com ([64.213.145.173]:29075 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S264919AbTBTPRX>;
	Thu, 20 Feb 2003 10:17:23 -0500
Date: Thu, 20 Feb 2003 10:27:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Sahani Himanshu <honeyuee@iitr.ernet.in>, linux-kernel@vger.kernel.org
Subject: Re: Adaptec drivers causing problem in RHL 8.0
Message-ID: <20030220152723.GA3146@gtf.org>
References: <Pine.GSO.4.05.10302201550440.2763-100000@iitr.ernet.in> <1316810000.1045754413@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1316810000.1045754413@aslan.scsiguy.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 08:20:13AM -0700, Justin T. Gibbs wrote:
> > I recently installed RHL 8.0 on a SGI1200 server. The server has 
> > "Adaptec AIC-7896 SCSI BIOS v2.20S1B1" installed.

> Those messages point to an interrupt routing problem.  The driver is
> not able to see interrupts from the chip, so timeouts occur.  Have
> you tries some of the various "apic/noapic" kernel options to see if
> your interrupt routing improves?  Often switching between UP and
> SMP kernels will change how interrupt routing is performed too.

Indeed, these are good avenues to poke.

FWIW, on Red Hat UP kernels, the "local IO-APIC" option is not even
compiled in.

	Jeff



