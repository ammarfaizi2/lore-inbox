Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264932AbRGSEBl>; Thu, 19 Jul 2001 00:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264942AbRGSEBc>; Thu, 19 Jul 2001 00:01:32 -0400
Received: from [216.6.80.34] ([216.6.80.34]:51983 "EHLO
	dcmtechdom.dcmtech.co.in") by vger.kernel.org with ESMTP
	id <S264932AbRGSEB0>; Thu, 19 Jul 2001 00:01:26 -0400
Message-ID: <7FADCB99FC82D41199F9000629A85D1A01C6506A@dcmtechdom.dcmtech.co.in>
From: Nitin Dhingra <nitin.dhingra@dcmtech.co.in>
To: "'Florin Andrei'" <florin@sgi.com>, linux-xfs@oss.sgi.com,
        seawolf-list@redhat.com, dledford@redhat.com,
        linux-kernel@vger.kernel.org
Subject: RE: noapic strikes back
Date: Thu, 19 Jul 2001 09:30:54 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess the problem is mostly of the scsi driver. 
Get the latest version scsi driver of that particular 
card and then try again. 

Regards,
Nitin


-----Original Message-----
From: Florin Andrei [mailto:florin@sgi.com]
Sent: Thursday, July 19, 2001 1:05 AM
To: linux-xfs@oss.sgi.com; seawolf-list@redhat.com; dledford@redhat.com;
linux-kernel@vger.kernel.org
Subject: noapic strikes back


I have a SGI 1200 (L440GX+ motherboard, dual PIII) and i'm trying to
install at least one version of Red Hat 7.1 on it.
The problem is, while booting up the installer, when it comes to loading
up the SCSI driver (AIC7xxx) the system is frozen.

I tried the following boot disks:
- stock Red Hat 7.1
- Doug Ledford's updates from people.redhat.com
- SGI XFS 1.0.1

I tried to boot the installer with and without "noapic" option.

I tried to enable and disable the APIC option in BIOS ("PCI IRQs to
IO-APIC Mapping").

I tried all the combinations of these. No luck. :-(

Please, is there anything to do about this problem? I *have* to install
something newer than RH7.0 on that system.

Guys, i will try whatever boot disks you will send to me. I'm willing to
be you guinea pig. :-) Just let's kill the APIC problem for good!

-- 
Florin Andrei

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
