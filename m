Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbVINXiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbVINXiI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 19:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbVINXiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 19:38:08 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:46971 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1030292AbVINXiH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 19:38:07 -0400
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
From: Redeeman <redeeman@metanurb.dk>
Reply-To: redeeman@metanurb.dk
To: Mathieu Fluhr <mfluhr@nero.com>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1126608030.3455.23.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
	 <1126608030.3455.23.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 01:38:03 +0200
Message-Id: <1126741083.7881.73.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-13 at 12:40 +0200, Mathieu Fluhr wrote:
<snip>
i have burning problems too, but have had with dvd's for.. well.. since
i got my burner, i think it was 2.6.10 or something, perhaps 2.6.9, but
it has gotten more frequent with 2.6.13, yes.

my problem is that i get input/output error, we have discussed this
earlier on this list, but people kept saying it was bad media, but if
that is so, every media is bad, and all the cases where i have bad media
is when i choose to burn in linux..

i use i have cdrecord and growisofs, i k3b, which uses those..

my lspci info:
redeeman@redeeman $ /sbin/lspci
~
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP]
Host Bridge (rev 01)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge
[K8T800/K8T890 South]
0000:00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80)
0000:00:0a.0 Ethernet controller: 3Com Corporation 3c940
10/100/1000Base-T [Marvell] (rev 12)
0000:00:0e.0 Multimedia controller: Philips Semiconductors SAA7134 Video
Broadcast Decoder (rev 01)
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA
RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[KT600/K8T800/K8T890 South]
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
0000:01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce
6600/GeForce 6600 GT] (rev a2)
------
i dont have an example dmesg error message now, but there is nothing to
it, its just a standard, hda input/output error..

one thing though, with kernels <2.6.13 i am able to simply cancel, and
burn again, with >2.6.13-rc* it freezes completely, and i gotta reboot
before i can get the dvd out.

i use the via ide driver in the kernel.

another thing, it happens at ~95-99% of the burning process in nearly
all cases, with one exception of half way through, and one case where it
was like 70%.

i hope this can help.


> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

