Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276639AbRJYXEb>; Thu, 25 Oct 2001 19:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276641AbRJYXET>; Thu, 25 Oct 2001 19:04:19 -0400
Received: from jalon.able.es ([212.97.163.2]:40339 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S276639AbRJYXED>;
	Thu, 25 Oct 2001 19:04:03 -0400
Date: Fri, 26 Oct 2001 01:04:32 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: gcc-3.0.2 and 2.4.14-pre1
Message-ID: <20011026010432.A1536@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Results of building with 3.0.2
- It works
- Kernel Sizes:
	903449 Oct 26 00:38 vmlinuz-2.4.14-pre1-beo			(2.96)
	864599 Oct 26 00:25 vmlinuz-2.4.14-pre1-beo.old		(3.0.2)
- Modules Sizes:
	2750    /lib/modules/2.4.14-pre1-beo
	2758    /lib/modules/2.4.14-pre1-beo.org
	werewolf:/lib/modules# modprobe -l | wc -l
   	  71

So it looks like the code is not bigger (modules) but some data structure
in main kernel...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.14-pre1-beo #3 SMP Fri Oct 26 00:27:18 CEST 2001 i686
