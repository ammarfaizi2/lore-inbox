Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263038AbUKTAVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263038AbUKTAVn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 19:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263030AbUKTASL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:18:11 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:28888 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262858AbUKTARU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:17:20 -0500
From: kernel-stuff <kernel-stuff@comcast.net>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: X86_64: Many Lost ticks
Date: Fri, 19 Nov 2004 19:17:12 -0500
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, acurrid@nvidia.com
References: <111820041702.27846.419CD5AD000313A800006CC6220588448400009A9B9CD3040A029D0A05@comcast.net> <200411182056.03184.kernel-stuff@comcast.net> <Pine.LNX.4.61.0411190856121.7201@musoma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0411190856121.7201@musoma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411191917.13165.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 November 2004 10:57, Zwane Mwaikambo wrote:
> Thanks for confirming that Parry, so your system definitely is using the
> IOAPIC now (/proc/interrupts output should suffice)?
>

Yes it does seem so. Here goes /proc/interrupts

          CPU0
  0:     138237    IO-APIC-edge  timer
  1:         77    IO-APIC-edge  i8042
  8:          0    IO-APIC-edge  rtc
  9:        198   IO-APIC-level  acpi
 12:       1427    IO-APIC-edge  i8042
 14:      11445    IO-APIC-edge  ide0
 15:        193    IO-APIC-edge  ide1
177:          0   IO-APIC-level  ehci_hcd
185:        382   IO-APIC-level  NVidia nForce3, ohci_hcd
193:          0   IO-APIC-level  NVidia nForce3 Modem, ohci_hcd
201:          4   IO-APIC-level  yenta, ohci1394
209:        289   IO-APIC-level  yenta, eth0
225:       7247   IO-APIC-level  nvidia
NMI:         59
LOC:     138123
ERR:          0
MIS:          0
