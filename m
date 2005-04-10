Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVDJXKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVDJXKh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVDJXKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:10:36 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:26344 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261633AbVDJXKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:10:18 -0400
Message-ID: <4259B24C.8030805@ens-lyon.org>
Date: Mon, 11 Apr 2005 01:10:04 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] radeonfb: (#2) Implement proper workarounds for PLL	accesses
References: <1110519743.5810.13.camel@gaston>	 <1110672745.5787.60.camel@gaston> <je8y3wyk3g.fsf@sykes.suse.de>	 <1112743901.9568.67.camel@gaston> <jeoecr1qk8.fsf@sykes.suse.de>	 <1112827655.9518.194.camel@gaston> <jehdii8hjk.fsf@sykes.suse.de>	 <21d7e9970504071422349426eb@mail.gmail.com>	 <1112914795.9568.320.camel@gaston> <jemzsa6sxg.fsf@sykes.suse.de>	 <1112923186.9567.349.camel@gaston> <jezmw9ug7j.fsf@sykes.suse.de>	 <1113005006.9568.402.camel@gaston> <jey8brj4tx.fsf@sykes.suse.de>	 <1113089591.9518.440.camel@gaston>	 <E1DKZJn-0001dN-KQ@localhost.localdomain> <1113173129.9568.501.camel@gaston>
In-Reply-To: <1113173129.9568.501.camel@gaston>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt a écrit :
>>But it's not specific to X11; I've applied the patch you posted and the
>>same symptoms occur for pure tty switching as well, the delay has decreased
>>a bit (it's hard to measure, but around a second), but it's still rather
>>annoying to work with.
>>
>>Is it distinguishable which M6 models are buggy? I'm using my X31 for about
>>a year now and have probably made some tens of thousands of switches without
>>lockups, so presumably not all models cause lockups.
> 
> 
> ATI hasn't been very precise about that unfortunately...

In case your interested, I tried your last patch 
(http://lkml.org/lkml/2005/4/7/308)
on top of 2.6.12-rc2-mm2 on my Radeon Mobility M6 LY.
It works great. Switching was at least one second long with plain mm2.
Now it's almost immediat as in Linus' kernel. No more dirty colors
during the switch from X to fbcon. Not annoying at all, here.

Thanks,
Brice
