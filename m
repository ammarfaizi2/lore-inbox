Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbUKSR2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbUKSR2L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 12:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbUKSR2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 12:28:11 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:27351 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261488AbUKSR2I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 12:28:08 -0500
Message-ID: <419E2D2B.4020804@free.fr>
Date: Fri, 19 Nov 2004 18:28:11 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org, Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       Adam Belay <ambx1@neo.rr.com>, "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr> <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0411191822030.9059@math.ut.ee>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos wrote:
>> So do you use pnpacpi ?
>> If so, could you send your dsdt and try with pnpbios?
> 
> 
> DSDT is here: http://www.cs.ut.ee/~mroos/toshsat1800_dsdt.img
> 

hum, your bios seem to build dynamically the resources (need an acpi 
expert for confirmation)

Could you send me the result of : "for i in /sys/bus/pnp/devices/*; do 
cat $i/id $i/options; done" in order to see if other devices have 
missing resources ?
