Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317034AbSHYH5b>; Sun, 25 Aug 2002 03:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317035AbSHYH5b>; Sun, 25 Aug 2002 03:57:31 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:32131 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S317034AbSHYH5a>;
	Sun, 25 Aug 2002 03:57:30 -0400
Message-ID: <3D688EE4.3060907@colorfullife.com>
Date: Sun, 25 Aug 2002 10:01:40 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re:  packet re-ordering on SMP machines.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > 2)  Is there any standard (ie configurable) way to enforce strict
 > ordering on an SMP system?

2 cpus, 2 network cards? What happens if you bind the interrupts to cpus?

echo 1 > /proc/irq/<irq_of_card_1>/smp_affinity
echo 2 > /proc/irq/<irq_of_card_2>/smp_affinity

--
	Manfred

