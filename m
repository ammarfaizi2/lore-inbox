Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266645AbTAOQRq>; Wed, 15 Jan 2003 11:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266665AbTAOQRp>; Wed, 15 Jan 2003 11:17:45 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:49101 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S266645AbTAOQRn>; Wed, 15 Jan 2003 11:17:43 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BD901@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'Martin J. Bligh'" <mbligh@aracnet.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "'Zwane Mwaikambo'" <zwane@holomorphy.com>,
       "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       "'haveblue@us.ibm.com'" <haveblue@us.ibm.com>
Subject: RE: [BUG] SLAB.C:1617-error on boot
Date: Wed, 15 Jan 2003 10:25:07 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, good... I was wondering why it was booting on after that trace like
nothing happened.

Thanks,

--Natalie

-----Original Message-----
From: Martin J. Bligh [mailto:mbligh@aracnet.com]
Sent: Wednesday, January 15, 2003 12:39 AM
To: Protasevich, Natalie; Linux Kernel
Cc: 'Zwane Mwaikambo'; 'Nakajima, Jun'; 'haveblue@us.ibm.com'
Subject: Re: [BUG] SLAB.C:1617-error on boot


It's just a warning ... I thing you'll find more info logged
on http://bugme.osdl.org ... I've been hitting that for ages
with no ill effects ;-)

--On Tuesday, January 14, 2003 22:13:26 -0600 "Protasevich, Natalie"
<Natalie.Protasevich@UNISYS.com> wrote:

> I get the error below consistently on boot with 2.5.58. Didn't see it with
> 2.5.56 (skipped 2.5.57).
> 
> .............................
> Detected 1899.559 MHz processor.
> 
> Console: colour VGA+ 80x25
> 
> Calibrating delay loop... 3702.78 BogoMIPS
> 
> Memory: 3952476k/3997504k available (2436k kernel code, 43892k reserved,
> 1280k data, 132k init, 3080000k highmem)
> 
> Debug: sleeping function called from illegal context at mm/slab.c:1617
> 
> Call Trace:
> 
>  [<c013b09c>] kmem_cache_alloc+0x74/0x76
> 
>  [<c013a2ca>] kmem_cache_create+0x72/0x5be
> 
>  [<c0105000>] _stext+0x0/0x56
> 
> 
> Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
> 
> Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
> 
> ................
> 
> 
> --Natalie
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

