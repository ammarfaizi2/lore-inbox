Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287882AbSATVxc>; Sun, 20 Jan 2002 16:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288089AbSATVxW>; Sun, 20 Jan 2002 16:53:22 -0500
Received: from flubber.jvb.tudelft.nl ([130.161.76.47]:12464 "EHLO
	mail.jvb.tudelft.nl") by vger.kernel.org with ESMTP
	id <S287882AbSATVxK>; Sun, 20 Jan 2002 16:53:10 -0500
From: "Robbert Kouprie" <robbert@jvb.tudelft.nl>
To: "'Kenneth MacDonald'" <kenny@holyrood.ed.ac.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: NIC lockup in 2.4.17 (SMP/APIC/Intel 82557)
Date: Sun, 20 Jan 2002 22:53:03 +0100
Message-ID: <005e01c1a1fc$d61eae50$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <yqo1ygkd8np.fsf@penguin.ucs.ed.ac.uk>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kenny,

Thanks for the quick reply :) Just checked it, and it's in slot 2, so
that's not the problem. It doesn't share the HPT366 IRQ. This is my
/proc/interrupts:

radium:/$ cat /proc/interrupts 
           CPU0       CPU1       
  0:    1207342    1186359    IO-APIC-edge  timer
  1:          3          1    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:         68         55    IO-APIC-edge  serial
  8:          2          0    IO-APIC-edge  rtc
 14:          6         12    IO-APIC-edge  ide0
 17:    1723020    1719230   IO-APIC-level  eth0
 18:      33419      33452   IO-APIC-level  ide2
 19:          0          0   IO-APIC-level  es1371
NMI:          0          0 
LOC:    2393677    2393676 
ERR:         14
MIS:          0

Regards,
- Robbert

> -----Original Message-----
> From: kenny@penguin.ucs.ed.ac.uk 
> [mailto:kenny@penguin.ucs.ed.ac.uk] On Behalf Of Kenneth MacDonald
> Sent: zondag 20 januari 2002 22:18
> To: Robbert Kouprie
> Subject: Re: NIC lockup in 2.4.17 (SMP/APIC/Intel 82557)
> 
> 
> Do you have the NIC in slot 3?  Read your motherboard manual, 
> page 1-4.
> 
> Hope that helps, just in case!
> -- 
> Kenny
> 
> ADML Support, EUCS, The University of Edinburgh, Scotland.
> 

