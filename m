Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265310AbTLHCyn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 21:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbTLHCyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 21:54:43 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:17163 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S265310AbTLHCyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 21:54:41 -0500
Message-ID: <3FD3EC3B.6080803@nishanet.com>
Date: Sun, 07 Dec 2003 22:12:59 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
References: <1070672114.2759.8.camel@big.pomac.com>
In-Reply-To: <1070672114.2759.8.camel@big.pomac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kumlien wrote:

>           CPU0
>  0:     267486    IO-APIC-edge  timer
>  1:       9654    IO-APIC-edge  keyboard
>  2:          0          XT-PIC  cascade
>  8:          1    IO-APIC-edge  rtc
>  9:          0   IO-APIC-level  acpi
> 14:      28252    IO-APIC-edge  ide0
> 15:        103    IO-APIC-edge  ide1
> 16:     251712   IO-APIC-level  eth0
> 17:      90632   IO-APIC-level  EMU10K1
> 19:     415529   IO-APIC-level  nvidia
> 20:          0   IO-APIC-level  usb-ohci
> 21:        153   IO-APIC-level  ehci_hcd
> 22:      58257   IO-APIC-level  usb-ohci
>NMI:        479
>LOC:     265875
>ERR:          0
>MIS:          0
>
note I have only PIC timer....

           CPU0      
  0:  244393560          XT-PIC  timer
  1:      31963    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:     251884    IO-APIC-edge  i8042
 14:         22    IO-APIC-edge  ide0
 15:         24    IO-APIC-edge  ide1
 16:    4290216   IO-APIC-level  3ware Storage Controller, yenta, yenta
 17:    5929405   IO-APIC-level  eth0
 21:          0   IO-APIC-level  NVidia nForce2
NMI:          0
LOC:  244378698
ERR:          0
MIS:          6

