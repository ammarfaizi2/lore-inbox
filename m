Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSHANu0>; Thu, 1 Aug 2002 09:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSHANu0>; Thu, 1 Aug 2002 09:50:26 -0400
Received: from [195.63.194.11] ([195.63.194.11]:56838 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313060AbSHANuZ>; Thu, 1 Aug 2002 09:50:25 -0400
Message-ID: <3D493C3B.2060609@evision.ag>
Date: Thu, 01 Aug 2002 15:48:43 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
References: <Pine.LNX.4.44.0208011541590.19906-100000@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Ingo Molnar napisa?:
> using 2.5.29 (vanilla or BK-curr) i cannot use /sbin/lilo anymore to
> update the partition table.
> 
> if i do it then the partition table gets corrupted and the system does not
> boot - it stops at 'LI'. (iirc meaning that the second-stage loader does
> not load?) Using a recovery CD fixes the problem, so it's only the
> partition info that got trashed, not the filesystem.
> 
> i use IDE disks.
> 
> this makes development under 2.5.29 quite inconvenient - i have to boot
> back into another kernel whenever loading a new kernel.

And what leads you to the assumption that it is actually the
IDE code, which is to be blamed for this?

