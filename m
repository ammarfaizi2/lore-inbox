Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbTAOHaN>; Wed, 15 Jan 2003 02:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbTAOHaN>; Wed, 15 Jan 2003 02:30:13 -0500
Received: from franka.aracnet.com ([216.99.193.44]:55265 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265806AbTAOHaL>; Wed, 15 Jan 2003 02:30:11 -0500
Date: Tue, 14 Jan 2003 23:38:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
cc: "'Zwane Mwaikambo'" <zwane@holomorphy.com>,
       "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       "'haveblue@us.ibm.com'" <haveblue@us.ibm.com>
Subject: Re: [BUG] SLAB.C:1617-error on boot
Message-ID: <827790000.1042616334@titus>
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C022BD900@usslc-exch-4.slc.unisys.com>
References: <3FAD1088D4556046AEC48D80B47B478C022BD900@usslc-exch-4.slc.unisys.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's just a warning ... I thing you'll find more info logged
on http://bugme.osdl.org ... I've been hitting that for ages
with no ill effects ;-)

--On Tuesday, January 14, 2003 22:13:26 -0600 "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com> wrote:

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


