Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWDSNhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWDSNhb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 09:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWDSNhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 09:37:31 -0400
Received: from rubis.org ([82.230.33.161]:2986 "EHLO rubis.org")
	by vger.kernel.org with ESMTP id S1750765AbWDSNha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 09:37:30 -0400
Message-ID: <44463CFA.9080207@rubis.org>
Date: Wed, 19 Apr 2006 15:36:58 +0200
From: =?UTF-8?B?IlN0w6lwaGFuZSAoa3dpc2F0eikgSm91cmRvaXMi?= 
	<kwisatz-lkml@rubis.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Martin Honermeyer <maze@strahlungsfrei.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3w-9xxx status in kernel
References: <4444D1D5.6070903@rubis.org> <e2558p$o5f$2@sea.gmane.org>
In-Reply-To: <e2558p$o5f$2@sea.gmane.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Honermeyer a écrit :
 > We are having performance problems using a 9550SX controller. Read
 > throughput (measured with hdparm) is worse than on a Desktop system. 
We are
 > considering trying to replace it with the newest driver from 3ware.com.

I saw somewhere in the knowledgebase on there website that 2.26.02 is 
newer than 2.26.04.

anyway :

Don't test using hdparm, it doesn't works (I don't know why). Test using 
bonnie++. I have 100MB/s throughput reading and writing on a 9550SX-12.
hdparm says 7MB/s.

Hope it helps.

Stéphane Jourdois.

-- 
  ///  Stephane Jourdois     /"\  ASCII RIBBON CAMPAIGN \\\
(((    Consultant securite  \ /    AGAINST HTML MAIL    )))
  \\\   24 rue Cauchy         X                         ///
   \\\  75015  Paris         / \    +33 6 8643 3085    ///
