Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbUCKQhS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 11:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbUCKQhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 11:37:18 -0500
Received: from ccs.covici.com ([209.249.181.196]:30630 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id S261183AbUCKQhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 11:37:12 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: shuttle an50r Motherboard and Linux
References: <m3wu5w8aex.fsf@ccs.covici.com>
	<200403080151.28816.bzolnier@elka.pw.edu.pl>
	<16460.36222.191866.759421@ccs.covici.com>
	<200403081633.38437.bzolnier@elka.pw.edu.pl>
	<16460.37707.806668.409270@ccs.covici.com>
From: John Covici <covici@ccs.covici.com>
Date: Thu, 11 Mar 2004 11:37:06 -0500
In-Reply-To: <16460.37707.806668.409270@ccs.covici.com> (John covici's
 message of "Mon, 8 Mar 2004 10:37:47 -0500")
Message-ID: <m3smgf8hn1.fsf@ccs.covici.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I have just tried 2.6.2 and although it recognizes the chip, it
sets all the disks to udma33 whereas I know at least two of them will
work at 133.

Any ideas?

on Mon, 8 Mar 2004 10:37:47 -0500 John covici <covici@ccs.covici.com> wrote:

> Sorry, here it is.
>
> 00:08.0 IDE interface: nVidia Corporation nForce3 IDE (rev a5) (prog-if 8a [Master SecP PriP])
> 	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device a550
> 	Flags: bus master, 66Mhz, fast devsel, latency 0
> 	I/O ports at f000 [size=16]
> 	Capabilities: [44] Power Management version 2
>
> on Monday 03/08/2004 Bartlomiej Zolnierkiewicz(B.Zolnierkiewicz@elka.pw.edu.pl) wrote
>  > On Monday 08 of March 2004 16:13, John covici wrote:
>  > > OK, here are the relevant parts of the lspci -v -- I have been using
>  > 
>  > IDE interface is missed.
>  > 
>  > > 2.4.22, but if it will make a difference I will try newer ones.
>  > 
>  > 2.4.x needs update of amd74xx.c driver.  2.6.x should be okay.
>  > 
>  > Bartlomiej
>
> -- 
>          John Covici
>          covici@ccs.covici.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
         John Covici
         covici@ccs.covici.com
