Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265274AbTLHCCL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 21:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265275AbTLHCCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 21:02:11 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:12040 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S265274AbTLHCCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 21:02:09 -0500
Message-ID: <3FD3DFEB.1010902@nishanet.com>
Date: Sun, 07 Dec 2003 21:20:27 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Catching NForce2 lockup with NMI watchdog
References: <20031205045404.GA307@tesore.local> <16336.13962.285442.228795@alkaid.it.uu.se> <20031205085829.GL29119@mis-mike-wstn.matchmail.com>
In-Reply-To: <20031205085829.GL29119@mis-mike-wstn.matchmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:

>for his motherboard.  It doesn't increment NMI in /proc/interrupts.  And it
>gives the above error message.  Isn't that a bug?
>  
>
> But nmi_watchdog=1 is supposed to work with APIC, or IO-APIC, and it isn't

Do you mean like this with an MSI K7N2 Delta MCP2-T mboard
and nmi in kernel and this in cat /proc/interrupts, also in /etc/lilo.conf
I have append="nmi_watchdog=1" ? Nothing "nmi" or "NMI" is logged.

 cat /proc/interrupts
           CPU0      
  0:  241105839          XT-PIC  timer
  1:      27337    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:     217952    IO-APIC-edge  i8042
 14:         22    IO-APIC-edge  ide0
 15:         24    IO-APIC-edge  ide1
 16:    4245875   IO-APIC-level  3ware Storage Controller, yenta, yenta
 17:    5428737   IO-APIC-level  eth0
 21:          0   IO-APIC-level  NVidia nForce2
NMI:          0
LOC:  241091187
ERR:          0
MIS:          6




