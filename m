Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129067AbQKBS1E>; Thu, 2 Nov 2000 13:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129069AbQKBS0y>; Thu, 2 Nov 2000 13:26:54 -0500
Received: from mail.zmailer.org ([194.252.70.162]:54020 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129067AbQKBS0n>;
	Thu, 2 Nov 2000 13:26:43 -0500
Date: Thu, 2 Nov 2000 20:26:21 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Cc: kernel@kvack.org
Subject: Re: Dual XEON - >>SLOW<< on SMP
Message-ID: <20001102202621.D10002@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.3.95.1001102090044.8621A-100000@chaos.analogic.com> <m3bsvy2qlb.fsf@otr.mynet.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3bsvy2qlb.fsf@otr.mynet.cygnus.com>; from drepper@redhat.com on Thu, Nov 02, 2000 at 10:09:36AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2000 at 10:09:36AM -0800, Ulrich Drepper wrote:
> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> > Yes. Look at the NMI count. Looks like every access produces a
> > NMI.
> 
> I'm seeing this as well, but only with PIII Xeon systems, not PII
> Xeon.  Every single timer interrupt on any CPU is accompanied by a NMI
> and LOC increment on every CPU.

	Same happens with PIII CopperMine too.
	I have Asus P2B-DS board and 1 GB RAM.

>            CPU0       CPU1       
>   0:     146727     153389    IO-APIC-edge  timer
> [...]
> NMI:     300035     300035 
> LOC:     300028     300028 

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
