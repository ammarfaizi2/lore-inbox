Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310806AbSDQRYW>; Wed, 17 Apr 2002 13:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310917AbSDQRYV>; Wed, 17 Apr 2002 13:24:21 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:34567
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S310806AbSDQRYQ>; Wed, 17 Apr 2002 13:24:16 -0400
Date: Wed, 17 Apr 2002 10:23:32 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam1
In-Reply-To: <20020417134004.GA2025@werewolf.able.es>
Message-ID: <Pine.LNX.4.10.10204171022360.12780-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yep

That is the bug on the ide_driveid_update call.
Find it and change the #if 1 to #if 0

Cheers,

On Wed, 17 Apr 2002, J.A. Magallon wrote:

> 
> On 2002.04.17 Andre Hedrick wrote:
> >There is a micro bug in 3a, look for 4 to arrive.
> >
> >regards
> >
> [...]
> >> 
> >> - ide update -3a (very shrinked wrt original, the big ppc part has gone
> >>   in mainline)
> 
> Can it be related to my system getting hung on boot trying to do
> an hdparm ?
> I had not the time to dig more, just disabled it and booted fine (I had
> some work to get done...)
> 
> TIA
> 
> -- 
> J.A. Magallon                           #  Let the source be with you...        
> mailto:jamagallon@able.es
> Mandrake Linux release 8.3 (Cooker) for i586
> Linux werewolf 2.4.19-pre7-jam1 #1 SMP Wed Apr 17 00:42:27 CEST 2002 i686
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

