Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271807AbRH1QdY>; Tue, 28 Aug 2001 12:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271808AbRH1QdF>; Tue, 28 Aug 2001 12:33:05 -0400
Received: from victor.ndsuk.com ([194.202.59.31]:65288 "EHLO victor.ndsuk.com")
	by vger.kernel.org with ESMTP id <S271807AbRH1QdE>;
	Tue, 28 Aug 2001 12:33:04 -0400
Message-ID: <F128989C2E99D4119C110002A507409801555EBD@topper.hrow.ndsuk.com>
From: "Elgar, Jeremy" <JElgar@ndsuk.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: RE: NFS Client and SMP
Date: Tue, 28 Aug 2001 17:33:59 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having a similar problem that I had been putting down to a problem with
an OpenBSD box,

Copying a large (n>20) number of file from local disk to an nfs share (on
the BSD box)
causes the server to totally freeze (have to reboot) normally have to bring
the local machines nic up and down to get anything back. kill's on the cp's
wont do anything

happened with each 2.4.x from 4 onwards, on an SMP Dual PIII 933 2Gb Ram

Oddly enough its only on a 'cp -r dir' or 'cp dir/*' it seems to hang, (so
much so that I have been doing a for each script hack, upto now.

All other machines (a mixture of Debian and open BSD boxes are okay)

I can supply / test if it turns out to be a linux problem.

Jeremy

  

> -----Original Message-----
> From: Oliver Paukstadt [mailto:pstadt@stud.fh-heilbronn.de]
> Sent: 28 August 2001 17:17
> To: Linux-Kernel
> Subject: NFS Client and SMP
> 
> 
> HY HY
> 
> I have massive problems using client nfs on SMP boxes.
> I can reproduce it 2.4.[0-7] on s390 and s390x and with 
> 2.4.[0-8] on IA32.
> 
> Try to reproduce starting massive IO on an nfs mounted 
> volume, eg. tar it
> to /dev/null.
> I tested it against verious servers, eg Slowlaris, HP-UX, 
> DEC, Linux 2.2,
> Linux 2.4, no tar survived.
> using NFS v2 or v3 caused no differences.
> One Intel we have to identical machines with identical setup 
> and only the
> box locks up running nfs client (we switched the roles of the boxes)
> 
> On S390 it took 5 to 30 minutes to lock the system, on Intel 
> sometimes it
> took up to 3 hours.
> 
> Running the system with only one cpu caused no hangs, all 
> tars finished.
> 
> BYtE Oli
> 
> +++LINUX++++++++++++++++++++++++++++++++++++++++++++++++++++++
> ++++++++++++
> +++Manchmal stehe ich sogar nachts auf und installiere mir 
> eins....+++++++
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> ++++++++++++ 
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


 
===============================================================
Information contained in this email message is intended only for
use of the individual or entity named above. If the reader of this
message is not the intended recipient, or the employee or agent
responsible to deliver it to the intended recipient, you are hereby
notified that any dissemination, distribution or copying of this
communication is strictly prohibited. If you have received this
communication in error, please immediately notify us by email
to postmaster@ndsuk.com and destroy the original message. 


