Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267605AbUHPMzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267605AbUHPMzZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 08:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267601AbUHPMzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 08:55:24 -0400
Received: from pD951EB5B.dip.t-dialin.net ([217.81.235.91]:12306 "EHLO
	sigma.witten.lan") by vger.kernel.org with ESMTP id S267609AbUHPMzF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 08:55:05 -0400
Message-ID: <4120AF41.4050400@gentoo.org>
Date: Mon, 16 Aug 2004 14:57:37 +0200
From: Danny van Dyk <kugelfang@gentoo.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de-AT; rv:1.7) Gecko/20040625
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: richard.brunner@amd.com
Cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Microcode Update Driver for AMD K8 CPUs
References: <C2BC72CDFC11A44083B660CAC2E9EA67257333@SAUSEXMB1.amd.com>
In-Reply-To: <C2BC72CDFC11A44083B660CAC2E9EA67257333@SAUSEXMB1.amd.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

richard.brunner@amd.com schrieb:
 >>Danny van Dyk <kugelfang@gentoo.org> writes:
 >>>I recently found some piece of code [1] to perform a microcode update
 >>>on AMD's K8 CPUs. It included some update blocks hardcoded into the
 >>>module.
 >>Several people found this code (including me). But I don't think
 >>it's a good idea right now to merge because it is better to leave
 >>these things to the BIOS. It's unlikely that AMD will regularly
 >>release "open" microcode updates anyways, and moving them
 >>between BIOSes seems a bit dangerous to me (often you likely
 >>need to change some magic MSRs too or you could have some
 >>side effects). Overall it seems to be too dangerous to
 >>do in a standard kernel.
 >>Also I suspect the driver won't work very well on SMP.
 >>-Andi
 > As usual, Andi is absolutely correct.
 > 	-Rich Brunner, AMD Fellow

Sigh. Well, that makes two *strong* votes against it.
Nevertheless, it's been a nice experience to work on that code.

Rich: Your CPUs are great ;-)

Andi: Can you explain to me, why you think that the module would not
work on SMP ? I don't know if this is still on topic: should we discuss
this off-list ? Vielleicht auf Deutsch *G ?

Danny

-- 
Danny van Dyk
Gentoo/AMD64 Developer
kugelfang@gentoo.org
