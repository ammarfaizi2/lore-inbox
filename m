Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314439AbSDRTfa>; Thu, 18 Apr 2002 15:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314440AbSDRTf3>; Thu, 18 Apr 2002 15:35:29 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:41736
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314439AbSDRTf3>; Thu, 18 Apr 2002 15:35:29 -0400
Date: Thu, 18 Apr 2002 12:34:29 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Heinz Diehl <hd@cavy.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam1
In-Reply-To: <20020418192728.GA1891@werewolf.able.es>
Message-ID: <Pine.LNX.4.10.10204181232090.17538-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the positive feedback!
About to add and test HPT372 final and then complete the MMIO operations.
Next will be to make the driver do the error recovery path that block does
not support and accellerate IO with true zero-copy.  Lastly will make the
entire stack modular, which is about 50% completed.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Thu, 18 Apr 2002, J.A. Magallon wrote:

> 
> On 2002.04.18 Heinz Diehl wrote:
> >On Wed Apr 17 2002, J.A. Magallon wrote:
> >
> >> Can it be related to my system getting hung on boot trying to do
> >> an hdparm ?
> >
> >Yep, here it is exactly the same.
> >
> >I also changed '#if 1' to '#if 0' as Andre mentioned but it has no effect,
> >my machine hangs at boot time....
> >
> 
> It worked for me, just booted fine with hdparm included...
> 
> -- 
> J.A. Magallon                           #  Let the source be with you...        
> mailto:jamagallon@able.es
> Mandrake Linux release 8.3 (Cooker) for i586
> Linux werewolf 2.4.19-pre7-jam1 #2 SMP Wed Apr 17 21:20:31 CEST 2002 i686
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

