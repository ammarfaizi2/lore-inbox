Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264438AbTLEXzp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 18:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264879AbTLEXzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 18:55:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:32232 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264438AbTLEXz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 18:55:27 -0500
X-Authenticated: #4512188
Message-ID: <3FD11AEB.5080305@gmx.de>
Date: Sat, 06 Dec 2003 00:55:23 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
CC: Allen Martin <AMartin@nvidia.com>,
       "'Jesse Allen'" <the3dfxdude@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F87E@mail-sc-6.nvidia.com> <3FD1199E.2030402@gmx.de>
In-Reply-To: <3FD1199E.2030402@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> *maybe* I found the bugger, at least I got APIC more stable (need to 
> test whether oit is really stable, compiling kernel right now...):

So, new kernel is up. So far so good:

            CPU0
   0:      47118          XT-PIC  timer
   1:         34    IO-APIC-edge  i8042
   2:          0          XT-PIC  cascade
   8:          3    IO-APIC-edge  rtc
   9:          0   IO-APIC-level  acpi
  12:        864    IO-APIC-edge  i8042
  14:         10    IO-APIC-edge  ide0
  15:         16    IO-APIC-edge  ide1
  16:          0   IO-APIC-level  Skystar2
  18:       7690   IO-APIC-level  libata
  19:       1910   IO-APIC-level  nvidia
  20:         43   IO-APIC-level  ohci_hcd, eth0
  21:        540   IO-APIC-level  NVidia nForce2
  22:          0   IO-APIC-level  ohci_hcd
NMI:          0
LOC:      46934
ERR:          0
MIS:          0


Prakash

