Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137141AbRAHSbT>; Mon, 8 Jan 2001 13:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143699AbRAHSbI>; Mon, 8 Jan 2001 13:31:08 -0500
Received: from f4.law8.hotmail.com ([216.33.241.4]:17683 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S137141AbRAHSaq>;
	Mon, 8 Jan 2001 13:30:46 -0500
X-Originating-IP: [170.148.65.7]
From: "Jason Perlow" <perlow@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Adaptec 19160 Problems
Date: Mon, 08 Jan 2001 18:30:39 
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F4USqo3X17UvgB7grec0001145c@hotmail.com>
X-OriginalArrivalTime: 08 Jan 2001 18:30:39.0755 (UTC) FILETIME=[19E5A5B0:01C079A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings (and Linus and Alan if youre listening, thanks):

I'm having a few bizarre problems with an adaptec 19160 scsi controller and 
several Linux distributions inlcluding Redhat 6.2 and 7.0, and I was 
wondering if anyone encountered anything similar and might be able to help.

The machine is an Athlon 1.2Ghz with 512MB PC133 RAM, Microstar VIA KT-133 
Pro2 motherboard, with twin Adaptec 19160 32-bit SCSI untra 3 controllers.

Both scsi chains are properly terminated with U-160 rated cable, both drives 
are recognized by adaptec's bios and utilities. Irregardless of which brand 
of Ultra160 10K RPM hard disk I use (I have several set up in removable bays 
as bootable devices), during the setup routine and boot sequence of every 
distro I have tried with 2.2 kernels, the drives initialize but the bus 
appears to constantly reset and the drives timeout and re-try to initialize 
again and again and again according to console error messages when the 
Adaptec 7892 module attempts to load, and I cant progress to the 
partitioning stages. The only way to get around this is to use an IDE boot 
device and use the disk as secondary storage.

This appears to occur with Redhat 6.2, Redhat 7, Mandrake 7.2 and Suse 7.0 . 
  I know the hardware configuration is ok because I am using one of the 
removable drives with Windows 2000 and Windows ME just fine.

I have also used these same drives on Linux with other machines that have 
similar adaptec U160 chipsets (SGI 330, IBM Intellistation) and with the 
29160 controller (64 bit PCI version of 7892 chipset) without these 
problems, so this is puzzling the hell out of me. I have also tried ripping 
these controllers out of this new athlon box and tried them as bootable 
devices in a Pentium III machine, same problems.

Anyone know who is responsible for the adaptec module? I'd love to be able 
to kick this in the bud or find out if it was resolved in 2.4.0

thanks in advance!


Jason Perlow
President, Argonaut Systems Corp
http://www.argonautsystems.com
perlow@hotmail.com

Media Affiliations:

Contributing Editor, Sm@rt Partner     www.smartpartnermag.com
Sr. Technology Editor, Linux Magazine  www.linux-mag.com
Contributing Editor, Maximum Linux     www.maximumlinux.com

138 Vista Drive, Cedar Knolls NJ 07927
(973)451-0215 (646)349-1324 eFax

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
