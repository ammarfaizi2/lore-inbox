Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbTI3Kee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 06:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbTI3Kee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 06:34:34 -0400
Received: from main.gmane.org ([80.91.224.249]:57750 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261277AbTI3Ked (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 06:34:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Schwarz <usenet.2117@andreas-s.net>
Subject: Re: ERR in /proc/interrupts
Date: Tue, 30 Sep 2003 10:34:31 +0000 (UTC)
Message-ID: <slrnbnin20.41m.usenet.2117@home.andreas-s.net>
References: <slrnbnijq7.41m.usenet.2117@home.andreas-s.net> <3F795816.7050805@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian wrote:
> Andreas Schwarz wrote:
>> I get a very high ERR count in /proc/interrupts. If I move my USB mouse
>> the number increases.
>> 
>> What does ERR mean? Nothing good, I suppose?
>> 
>
> ../Documentation/filesystems/proc.txt says:
>
> ERR is incremented in the case of errors in the IO-APIC bus (the bus 
> that connects the CPUs in a SMP system. This means that an error has 
> been detected, the IO-APIC automatically retry the transmission, so it 
> should not be a big problem, but you should read the SMP-FAQ.

I don't have a SMP kernel. I compiled the kernel with IO APIC support,
but disabled it later with the noapic kernel boot option.

-- 
AVR-Tutorial, über 350 Links
Forum für AVRGCC und MSPGCC
-> http://www.mikrocontroller.net

