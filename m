Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277873AbRJIRnh>; Tue, 9 Oct 2001 13:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277872AbRJIRnb>; Tue, 9 Oct 2001 13:43:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52228 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277873AbRJIRnP>; Tue, 9 Oct 2001 13:43:15 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Sticky/Key-Setable SysRq (resubmit)
Date: 9 Oct 2001 10:43:32 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9pvd04$9sd$1@cesium.transmeta.com>
In-Reply-To: <20011009105251.A20842@mueller.datastacks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011009105251.A20842@mueller.datastacks.com>
By author:    Crutcher Dunnavant <crutcher@datastacks.com>
In newsgroup: linux.dev.kernel
> 
> Attached is the patch from last week which provides the sysrq system
> with the following:
> 
> a toggleable 'sticky' flag in /proc, which makes the sysrq key work on bad
> keyboards, and through bad KVMs.
> 
> the ability to set which key in /proc, which makes the sysrq key work on
> system _without_ a 'sysrq' key; like bad KVMs.
> 
> I've gotten no tracktion on this in a week, so I'm resubmitting it.
> 

I think doing this through procfs might be reasonable, but a kernel
command line option would be absolutely mandatory.  If things are
crappy you might not get to the point of fidding with /proc.

Also, I really think SysRq has nothing to do under "Kernel
Hacking/Kernel Debugging".  More than anything else it's a system
administration feature.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
