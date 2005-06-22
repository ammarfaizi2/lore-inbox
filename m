Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVFVPuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVFVPuk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVFVPqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:46:33 -0400
Received: from magic.adaptec.com ([216.52.22.17]:28049 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261538AbVFVPoI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:44:08 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.4 and aacraid dmesg
Date: Wed, 22 Jun 2005 11:43:18 -0400
Message-ID: <60807403EABEB443939A5A7AA8A7458B0152148D@otce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4 and aacraid dmesg
Thread-Index: AcV3PoB5dSMzAwUsTZe3P5Z5Ft0Y/AAALeQg
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Gabor Z. Papp" <gzp@papp.hu>
Cc: "Mark Haverkamp" <markh@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabor Z. Papp [mailto:gzp@papp.hu] writes:

>| on PCI address 03:0d.0 and 03:09.0 are sharing IRQ 4. The 'info'
message
>| is printed every time the pcibios_enable_device() call is made. The
>| interrupt sharing is assigned by the Motherboard BIOS and if you have
>| subsequent problems with the operation of the card(s) or the system,
you
>| should investigate updating the Motherboard BIOS or go into the
>| motherboard BIOS setup and see if you can reassign the PCI (IRQ)
>| resources.
>Okay. The other device at 03:09.0 is a:
>
>Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)

Do you really need the audio card? :-) I'd toss (or disable) the audio
system in a heart beat just to remove the annoyance of the messages.

> Anyway, I love this 2120S, boots quite slooowly, but works fine and
stable.

Do keep the F/W up-to-date if you should run into problems. The driver
is thin for this card, most stability issues center around targets,
target compatibility & Hardware (some issues can even trace to Power
Supply problems).

The 2200S is more than four times as fast (when stressed to the
maximum), the 2120S was meant for 'budget' scenarios with feature
completeness in mind.

> Ah, the chip is *very* *very* *very* hot on the card, is that normal?

I can put my hand on the CPU and keep it there with only a smidgen of
concern and nary a sizzling sound. I would worry if you could cook eggs
on it. Do you have a means to measure the actual temperature to add some
objectivism? If so, I'd compare it to the chip's (clearly marked, can be
substituted) specification maximums if you want to get more comfortable
with it.

-- Mark Salyzyn
