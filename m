Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130083AbRBZAyz>; Sun, 25 Feb 2001 19:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130090AbRBZAyr>; Sun, 25 Feb 2001 19:54:47 -0500
Received: from jdewell.coloc.xmission.com ([204.228.135.205]:641 "HELO
	a.smtp.woods.net") by vger.kernel.org with SMTP id <S130086AbRBZAyc>;
	Sun, 25 Feb 2001 19:54:32 -0500
Date: Sun, 25 Feb 2001 17:56:37 -0700 (MST)
From: Aaron Dewell <acd@woods.net>
To: linux-kernel@vger.kernel.org
Subject: Re: can't boot sparc32 2.4.x (level 15 interrupt)
In-Reply-To: <Pine.GSO.4.10.10102251151370.1625-100000@spruce.woods.net>
Message-ID: <Pine.GSO.4.10.10102251755570.1625-100000@spruce.woods.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just realized (ok, blond moment :) that it's probably SMP related.  Of 
course, I turned on SMP.  Is there any known issues with sparc32 and SMP?

On Sun, 25 Feb 2001, Aaron Dewell wrote:
> Hi all,
> 
> I'm seeing some problems booting a sparc20 with 2.4.x.  Same results
> with 2.4.0, 2.4.1, and 2.4.2, and I tried some quantity of -ac* patches
> as well.  My kernel configuration is included.
> 
> For the example included it's booting from a serial console, but I got
> the same result with the keyboard+monitor connected.  It is currently
> running 2.2.18.  I can send any more information that's useful.
> 
> Hardware:
> 
> Sparc20
> 2xSM71
> hme
> 6x64MB SIMMS
> 2x8MB VSIMMS
> cdrom, hd, etc.
> External Zip 100 on external bus (not the hme bus)
> All the builtin stuff:  dbri, cg14, esp, lance, etc.
> 
> I'm not sure how relevant all that is, but there it is just in case.  I
> can test patches, but I'm not that good at kernel hacking to the point
> of being able to produce one for this.  Actually, I can't say it's all
> sparc32s, because I only have two, and they are both the same
> configuration.  An Ultra next to it works well with 2.4.x.
> 
> Aaron
> 
> 
> SPARCstation 20 MP (2 X SuperSPARC-II), No Keyboard
> ROM Rev. 2.25, 384 MB memory installed, Serial #8467761.
> Ethernet address 8:0:20:81:35:31, Host ID: 72813531.
> 
> 
> 
> Boot device: /iommu/sbus/espdma@f,400000/esp@f,800000/sd@3,0  File and args: 
> SILO boot: 
> Uncompressing image...
> PROMLIB: obio_ranges 5
> bootmem_init: Scan sp_banks,  init_bootmem(spfn[226],bpfn[226],mlpfn[c000])
> free_bootmem: base[0] size[c000000]
> reserve_bootmem: base[0] size[226000]
> reserve_bootmem: base[226000] size[1800]
> Level 15 Interrupt
> Type  help  for more information
> <#2> ok 

