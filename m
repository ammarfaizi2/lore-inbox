Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310658AbSCHClL>; Thu, 7 Mar 2002 21:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310657AbSCHClB>; Thu, 7 Mar 2002 21:41:01 -0500
Received: from stargazer.compendium-tech.com ([64.156.208.76]:65464 "EHLO
	stargazer.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S310658AbSCHCko>; Thu, 7 Mar 2002 21:40:44 -0500
Date: Thu, 7 Mar 2002 18:40:22 -0800 (PST)
From: Kelsey Hudson <khudson@compendium-tech.com>
To: Holger Lubitz <h.lubitz@internet-factory.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 160gb maxtor with promise ultra 100
In-Reply-To: <3C87C6CB.F05C3B96@internet-factory.de>
Message-ID: <Pine.LNX.4.44.0203071839270.16402-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002, Holger Lubitz wrote:

> recently i installed two 160gb maxtor drives. using the latest ac-kernel
> (.19-pre2-ac3), they were detected correctly. however, the promise ultra
> 100 (detected as pdc 20267) hangs at the partition check. last thing it
> prints is "hde:" and it's dead. however, if i connect the drives to the
> onboard piix3 ide, they are detected correctly, survive the partition
> check, and _do_ work as 160gb drives, but slow (piix3 only supports
> mdma2, no udma). if i boot the latest non-ac-kernel available on the
> machine (which is the not so recent 2.4.14) the drives are misdetected
> as only 137gb (of course, no 48 bit support) but otherwise the machine
> works, even with the drives connected to the promise.
> 
> so the situation is - either i use the full 160 gb, but only mdma2 data
> transfer. or i use udma 100, but only 137 gb of the drives. i can't seem
> to have both.
> 
> i am out of ideas what might be causing this. of course i could just
> throw the promise out and leave the drives connected to the on board
> controller, but... other ideas?

Check promise's website for a bios update for the controller. the earlier 
versions of the ultra100 don't have 48 bit lba support, if i recall 
correctly.


 Kelsey Hudson                                           khudson@ctica.com 
 Associate Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     
==== 0100101101001001010000110100101100100000010010010101010000100001 =====


