Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131408AbRC0Qdn>; Tue, 27 Mar 2001 11:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131409AbRC0Qdd>; Tue, 27 Mar 2001 11:33:33 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:60432
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131408AbRC0QdW>; Tue, 27 Mar 2001 11:33:22 -0500
Date: Tue, 27 Mar 2001 08:32:16 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Promise RAID controller howto?
In-Reply-To: <99q1g2$air$1@forge.intermeta.de>
Message-ID: <Pine.LNX.4.10.10103270806300.16125-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001, Henning P. Schmiedehausen wrote:

> Hi,
> 
> I know, that this is a FAQ and the Promise RAID controller card is not
> yet usable as a RAID board under Linux 2.x but is there a way to use
> the controller just like the UltraATA 100 controller?

It is not a raid board ... it is a raid lie

> I know, that "input high == UltraATA core, input low = RAID core"
> according to Andre Hedrick but I really don't care about the RAID
> core. I want to use this controller to drive JBOD.

Wrong, if Promise will opensource the signatures then we map the software
raid against that location and use Linux's soft-raid.


> Can one do this? The disks need not to be interchangeable to other
> controllers.  Just be accessible.
> 
> 2.2 solutions preferred, 2.4 ok.
> 
> 	Regards
> 		Henning
> 
> -- 
> Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
> INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de
> 
> Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
> D-91054 Buckenhof     Fax.: 09131 / 50654-20   
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

