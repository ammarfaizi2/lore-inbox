Return-Path: <linux-kernel-owner+w=401wt.eu-S1751365AbXALNZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbXALNZf (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 08:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbXALNZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 08:25:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:60492 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbXALNZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 08:25:34 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GGnJ4eOhtgNuD2D7cSevuC+01VoZRlNYVhFAbrCh8kRjLVlfwVIba+UDVIzakv0bPylmYywNr2uT21yoJzJe9VccNthxG3sART4Cnk+yRBBksKfBY+mv7lLCux8T7ni5JLmQUY8vi2rog5DrcdwPDZWWPCKsGVm1pmD7UJaLzwo=
Message-ID: <8355959a0701120525m5d1a7904i56b8a8f7316883d6@mail.gmail.com>
Date: Fri, 12 Jan 2007 18:55:32 +0530
From: "Sunil Naidu" <akula2.shark@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Choosing a HyperThreading/SMP/MultiCore kernel ?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

There are 2 cases:-

#1 Intel Pentium 4 Workstation with HyperThreading

Since kernel takes HT as 2 processors, I did say in KConfig as:

CONFIG_SMP= y
CONFIG_NR_CPUS=2
CONFIG_SCHED_MC=not set
CONFIG_MPENTIUM4=y (Or should I say CONFIG_X86_PC=y)
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=not set
RESOURCES_64BIT=not set
HOTPLUG_CPU=not set


Pl correct me if am wrong.


#2 Intel Core2Duo Processor - Laptop

CONFIG_SMP= y
CONFIG_NR_CPUS=4 ??
CONFIG_SCHED_MC=y
CONFIG_X86_PC=y ?  (if wrong, what should I set for Xeon QuadCore)
CONFIG_SCHED_SMT=not set
CONFIG_SCHED_MC=y
RESOURCES_64BIT=not set
HOTPLUG_CPU=not set

I didn't start this yet (still with Mac, will install in weekend), is
this correct one?

[OT] I don't know if I can ask about a suggested distro here or not?
Anyway, me read that Fedore & Yellow Dog suits well for this?


Thanks,
~Akula2
