Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbULZP6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbULZP6c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 10:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbULZP6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 10:58:31 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:54146 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261687AbULZP5y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 10:57:54 -0500
Message-ID: <41CEDF96.7000408@verizon.net>
Date: Sun, 26 Dec 2004 10:58:14 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: ultralinux@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc64: remove x86-specific SMP reference in Kconfig
References: <20041226134715.11731.39190.49206@localhost.localdomain> <Pine.LNX.4.61.0412260839020.17702@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0412260839020.17702@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [209.158.220.243] at Sun, 26 Dec 2004 09:57:53 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Sun, 26 Dec 2004, James Nelson wrote:
> 
> 
>>Remove inapplicable references to x86 SMP configuration in arch/sparc64/Kconfig.
>>
>> 	  People using multiprocessor machines who say Y here should also say
>> 	  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
>> 	  Management" code will be disabled if you say Y here.
> 
> 
> APM isn't applicable to sparc64 either.
> 
> 
>> 	  See also the <file:Documentation/smp.txt>,
>>-	  <file:Documentation/i386/IO-APIC.txt>,
>> 	  <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
> 
> 
> Nor is the nmi watchdog.
> 

Right.  Let me re-work and re-submit.

Jim
