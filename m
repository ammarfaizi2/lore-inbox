Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQLQIKy>; Sun, 17 Dec 2000 03:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129933AbQLQIKn>; Sun, 17 Dec 2000 03:10:43 -0500
Received: from va-ext.webmethods.com ([208.234.160.252]:54040 "EHLO
	localhost.neuron.com") by vger.kernel.org with ESMTP
	id <S129348AbQLQIKc>; Sun, 17 Dec 2000 03:10:32 -0500
Date: Sun, 17 Dec 2000 02:41:51 -0500 (EST)
From: <stewart@neuron.com>
To: Mathias Wiklander <eastbay@linux.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx
In-Reply-To: <3A3C2116.46C60CDE@linux.se>
Message-ID: <Pine.LNX.4.10.10012170237090.757-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 I am also having problems with this driver, but with different adapters
 and symptoms. depmod is reporting a lot of unresolved symbols for generic
 scsi and scsi cdrom. Compiling it into the kernel instead of as a module
 seems to bypass the problems.

 stewart


On Sun, 17 Dec 2000, Mathias Wiklander wrote:

> Hi!
> 
> I have problem using my scsi card. It is an Adaptec 2940 (SCSI2). When
> ever I try to load it as a module or if I compile it in the kernel I get
> the folowing error messages. The last 4 messages repeats for ever. The
> problem is on 3 diffrent machines. Anyone who know what it can be and
> how to fix it. 
> 
> /Eastbay
> 
> (scsi0) <Adaptec AHA-294X SCSI host adapter> found at PCI 0/19/0
> (scsi0) Narrow Channel, SCSI ID=7, 16/255 SCBs
> (scsi0) Cables present (Int-50 NO, Ext-50 NO)
> (scsi0) Downloading sequencer code... 415 instructions downloaded
> scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
>        <Adaptec AHA-294X SCSI host adapter>
> scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0,
> lun 0 Inquiry 00 00 00 ff 00 
> SCSI host 0 abort (pid 0) timed out - resetting
> SCSI bus is being reset for host 0 channel 0.
> SCSI host 0 channel 0 reset (pid 0) timed out - trying harder
> SCSI bus is being reset for host 0 channel 0.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
