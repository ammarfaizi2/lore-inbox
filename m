Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318296AbSGRT54>; Thu, 18 Jul 2002 15:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318318AbSGRT54>; Thu, 18 Jul 2002 15:57:56 -0400
Received: from ausadmmsrr503.aus.amer.dell.com ([143.166.83.90]:58888 "HELO
	AUSADMMSRR503.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S318296AbSGRT5z>; Thu, 18 Jul 2002 15:57:55 -0400
X-Server-Uuid: 91331657-2068-4fb8-8b09-a4fcbc1ed29f
Message-ID: <F44891A593A6DE4B99FDCB7CC537BBBB072538@AUSXMPS308.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: RSinko@island.com, linux-kernel@vger.kernel.org
Subject: RE: Wrong CPU count
Date: Thu, 18 Jul 2002 15:00:49 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 1129C1F93154245-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After upgrading  from kernel 2.4.7-10smp to 2.4.9-34smp using 
> the Red Hat
> RPM downloaded from RH Network, the CPU count on the machine 
> reported by
> dmesg and listed in /proc/cpuinfo was 4 rather than the actual 2.
> 
> This has occured on all 4 Dell 2650's that I've installed 
> this patch on.  I
> don't have any other mult-processor machines available to 
> test this with.

Congratulations, you purchased a fine PowerEdge 2650 with processors which
contain HyperThreading technology.  Each physical processor appears as two
logical processors.  This behaviour is expected, and correct. :-)

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)

