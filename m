Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276997AbRJKWvD>; Thu, 11 Oct 2001 18:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277013AbRJKWux>; Thu, 11 Oct 2001 18:50:53 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:54030 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S276997AbRJKWud>; Thu, 11 Oct 2001 18:50:33 -0400
Date: Thu, 11 Oct 2001 18:51:04 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Sticky/Key-Setable SysRq (resubmit)
Message-ID: <20011011185104.B32585@mueller.datastacks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011009105251.A20842@mueller.datastacks.com> <9pvd04$9sd$1@cesium.transmeta.com> <3BC40C41.5040603@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BC40C41.5040603@wipro.com>; from balbir.singh@wipro.com on Wed, Oct 10, 2001 at 02:22:17PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 10/10/01 14:22 +0530 - BALBIR SINGH:
> H. Peter Anvin wrote:
> 
>  >Followup to:  <20011009105251.A20842@mueller.datastacks.com>
>  >By author:    Crutcher Dunnavant <crutcher@datastacks.com>
>  >In newsgroup: linux.dev.kernel
>  >
>  >>Attached is the patch from last week which provides the sysrq system
>  >>with the following:
>  >>
>  >>a toggleable 'sticky' flag in /proc, which makes the sysrq key work 
> on bad
>  >>keyboards, and through bad KVMs.
>  >>
>  >>the ability to set which key in /proc, which makes the sysrq key work on
>  >>system _without_ a 'sysrq' key; like bad KVMs.
>  >>
>  >>I've gotten no tracktion on this in a week, so I'm resubmitting it.
>  >>
>  >
>  >I think doing this through procfs might be reasonable, but a kernel
>  >command line option would be absolutely mandatory.  If things are
>  >crappy you might not get to the point of fidding with /proc.
>  >
>  >Also, I really think SysRq has nothing to do under "Kernel
>  >Hacking/Kernel Debugging".  More than anything else it's a system
>  >administration feature.
>  >
>  >	-hpa
>  >
> 
> Also, when configuring the kernel you can decide not to have /proc 
> mounted (although this is very rare), but it might happen, if somebody 
> decided not to use it, so as suggested, I think a kernel command line 
> option would be nice.
> 
> Balbir

This gets into a realm of advanced/robust features which I want to add
when 2.5 opens up. I will remember it, but right now I not seeing any
traction on this at all.


-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
