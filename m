Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUI1Kqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUI1Kqr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 06:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266705AbUI1Kqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 06:46:47 -0400
Received: from eth1023.nsw.adsl.internode.on.net ([150.101.206.254]:11328 "EHLO
	naya.ABOOSPLANET.COM") by vger.kernel.org with ESMTP
	id S261232AbUI1Kqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 06:46:44 -0400
From: "Aboo Valappil" <aboo@aboosplanet.com>
To: "'Alex Riesen'" <raa.lkml@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Switch back to Real mode and then boot strap
Date: Tue, 28 Sep 2004 20:46:40 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcSlRPM2t5O4H3RCTluurruNU+2pWgAAZSSA
In-Reply-To: <81b0412b0409280321235178f1@mail.gmail.com>
Message-ID: <NAYArRjbDt3HvoFOAmE00000009@naya.ABOOSPLANET.COM>
X-OriginalArrivalTime: 28 Sep 2004 10:46:42.0839 (UTC) FILETIME=[712F9A70:01C4A548]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex,

Thanks for your reply, it is really good if I have to load another kernel.
But in my case the OS on the hard disk could be Windows, Linux or x86
Solaris. A reboot is required from Linux booted from floppy/ramdisk after
the hard disk has been imaged with requested operating system by a user. 

Because of the automated behavior of this, changing the boot sequence is not
an option. That is why I am after executing real mode BIOS interrupts to
load the MBR and then pass control to it. 

Any help will be appreciated :)

Thanks

Aboo


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Alex Riesen
Sent: Tuesday, September 28, 2004 8:22 PM
To: Aboo Valappil
Cc: linux-kernel@vger.kernel.org
Subject: Re: Switch back to Real mode and then boot strap

On Tue, 28 Sep 2004 20:11:59 +1000, Aboo Valappil <aboo@aboosplanet.com>
wrote:
> Basically I have a requirement of re-booting ( Without really rebooting )
> the OS from the hard disk ( even if a floppy is present or a bootable
CD-ROM
> is present).  Update CMOS to change the boot sequence is not an option for
> my requirement.

You probably want to look at kexec.
I.e. there: http://lwn.net/Articles/15468/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


