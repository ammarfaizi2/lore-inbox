Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265507AbRFWBgx>; Fri, 22 Jun 2001 21:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265528AbRFWBgn>; Fri, 22 Jun 2001 21:36:43 -0400
Received: from jalon.able.es ([212.97.163.2]:43436 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S265507AbRFWBge>;
	Fri, 22 Jun 2001 21:36:34 -0400
Date: Sat, 23 Jun 2001 03:20:47 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Keith Owens <kaos@ocs.com.au>
Cc: "Justin T . Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx
Message-ID: <20010623032047.A14928@werewolf.able.es>
In-Reply-To: <200106221939.f5MJdjU78255@aslan.scsiguy.com> <10972.993257428@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <10972.993257428@ocs3.ocs-net>; from kaos@ocs.com.au on Sat, Jun 23, 2001 at 02:50:28 +0200
X-Mailer: Balsa 1.1.6-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010623 Keith Owens wrote:
>
>>What again are you trying to fix?  It looks to me like you are simply
>>trying to make it harder for people actually working on the aic7xxx
>>driver to have proper dependencies.
>
>The patch still works for anybody changing the aic7xxx firmware or the
>aicasm code.  Any change to the generated files or the aicasm files now
>forces a rebuild, the option is not required.  Only people changing
>aic7xxx firmware are affected, instead of everybody.
>

It is easier than that. Nobody should be rebuilding the firmware apart
from driver mantainers. If driver version in 2.4.5 is 6.1.13, that version
includes a certain firmware in .h format and that is all. Apart from
this, the author (Justin) can make available in his web page one other
package for driver testers or developers including aicasm and firmware
source. But that should not be in the kernel tree.
If there are updates to the firmware, just send the patch for .h files
to kernel mantainers and/or lkml, as everybody does.

This is easier, doesn't it ?

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac17 #2 SMP Fri Jun 22 01:36:07 CEST 2001 i686
