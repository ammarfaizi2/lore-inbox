Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262782AbSITPc1>; Fri, 20 Sep 2002 11:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262785AbSITPc0>; Fri, 20 Sep 2002 11:32:26 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:2577 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S262782AbSITPcZ>; Fri, 20 Sep 2002 11:32:25 -0400
Date: Fri, 20 Sep 2002 09:37:11 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Ville Herva <vherva@niksula.hut.fi>, linux-kernel@vger.kernel.org
cc: Jani Forssell <jani.forssell@viasys.com>
Subject: Re: 2.4.20pre7, aic7xxx-6.2.8: Panic: HOST_MSG_LOOP with invalid
 SCB 0
Message-ID: <1184680000.1032536231@aslan.scsiguy.com>
In-Reply-To: <20020920052832.GH41965@niksula.cs.hut.fi>
References: <20020920052832.GH41965@niksula.cs.hut.fi>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Celeron 1.3GHz, Intel i815 chipset, 512MB ram.
> 
> AIC-2640 PCI card with uw and narrow connectors. A Seagate scsi disk
> (rootfs) attached to uw, and a HP tape drive attached to narrow. Tape
> drive never used.
> 
> I only ran 2.4.20pre7 (no other patches) for a night and it crashed:
> 
> -------------------------------------------------------------------
> Kernel panic: HOST_MSG_LOOP with invalid SCB 0
> 
> In interrupt handler, not syncing

I need all of the messages leading up to the panic in order to
diagnose this.  You may need to use a serial console to get
them all.

--
Justin
