Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVBZDjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVBZDjx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 22:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVBZDjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 22:39:53 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:38072 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261380AbVBZDjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 22:39:51 -0500
Message-ID: <421FEF81.2070806@g-house.de>
Date: Sat, 26 Feb 2005 04:39:45 +0100
From: Christian <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sven Luther <sven.luther@wanadoo.fr>
CC: Tom Rini <trini@kernel.crashing.org>, Meelis Roos <mroos@linux.ee>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org, Sven Hartge <hartge@ds9.gnuu.de>
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII Utah)
 PCI IRQ map
References: <20041206185416.GE7153@smtp.west.cox.net> <Pine.SOC.4.61.0502221031230.6097@math.ut.ee> <20050224074728.GA31434@pegasos> <Pine.SOC.4.61.0502241746450.21289@math.ut.ee> <20050224160657.GB11197@pegasos> <421E7033.1030600@g-house.de> <20050225063609.GA21244@pegasos> <49984.195.126.66.126.1109332744.squirrel@housecafe.dyndns.org> <20050225121536.GA20174@pegasos>
In-Reply-To: <20050225121536.GA20174@pegasos>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Luther wrote:
> Some backports that i got from the list. The complete list of patches is at :
> 
>   http://svn.debian.org/wsvn/kernel/trunk/kernel/source/kernel-source-2.6.8-2.6.8/debian/patches/?rev=0&sc=0

dooh, these websvn patches are giving me a headache.... will have to 
learn /usr/bin/svn first :-\


> --- kernel-source-2.6.8.orig/arch/ppc/platforms/prep_pci.c	2004-12-28

yes, the prep_pci.c and its irq-mappings. the PowerStackII lines were 
changed back and forth, and a current 2.6-BK is only different in one 
line to the patch you mentioned:

http://nerdbynature.de/bits/hal/2.6.11-rc5.patched/powerpc-prep-powerstack-irq_2.6.11-rc5.patch

unfortunately it did not help either and i'll switch back to vanilla 
2.6.8 again and hopefully find out exactly when scsi stopped working.

http://nerdbynature.de/bits/hal/2.6.11-rc5/
http://nerdbynature.de/bits/hal/2.6.11-rc5.patched/


thank you for your concern,
Christian.
