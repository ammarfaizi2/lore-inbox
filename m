Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316643AbSEWNXv>; Thu, 23 May 2002 09:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316660AbSEWNXu>; Thu, 23 May 2002 09:23:50 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:5267 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316643AbSEWNXt>;
	Thu, 23 May 2002 09:23:49 -0400
Date: Thu, 23 May 2002 18:57:20 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: ia64 code having CONFIG_X86_LOCAL_APIC
Message-ID: <20020523185719.Z2518@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
linux-2.5.17/arch/ia64/kernel/irq.c has a
#ifdef CONFIG_X86_LOCAL_APIC,
but I dont see the config option in any ia64 config.in files.....
wondering if this is just some piece of code which will never be compiled...

Also, linux-2.5.17/arch/ia64/kernel/irq.c prints apic_timer_irqs, and they
don't seem to be defined for ia64.  The piece of code (irq.c) is also covered 
by 
#ifdef CONFIG_X86
wonder if the condition is ever true.....

Pls let me know what I am missing

disclaimer: I don't know much about ia64 

Kiran

