Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267313AbUHPBZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267313AbUHPBZv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 21:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUHPBZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 21:25:51 -0400
Received: from amdext4.amd.com ([163.181.251.6]:58305 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S267313AbUHPBZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 21:25:49 -0400
Message-ID: <C2BC72CDFC11A44083B660CAC2E9EA67257333@SAUSEXMB1.amd.com>
From: richard.brunner@amd.com
To: ak@muc.de, kugelfang@gentoo.org
cc: linux-kernel@vger.kernel.org
Subject: RE: [RFC] Microcode Update Driver for AMD K8 CPUs
Date: Sun, 15 Aug 2004 20:24:57 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 6D3ED365548818-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>Danny van Dyk <kugelfang@gentoo.org> writes:
>
>> I recently found some piece of code [1] to perform a microcode update
>> on AMD's K8 CPUs. It included some update blocks hardcoded into the
>> module.

>Several people found this code (including me). But I don't think
>it's a good idea right now to merge because it is better to leave
>these things to the BIOS. It's unlikely that AMD will regularly
>release "open" microcode updates anyways, and moving them
>between BIOSes seems a bit dangerous to me (often you likely
>need to change some magic MSRs too or you could have some 
>side effects). Overall it seems to be too dangerous to 
>do in a standard kernel. 
>
>Also I suspect the driver won't work very well on SMP. 
>
>-Andi

As usual, Andi is absolutely correct.

	-Rich Brunner, AMD Fellow

