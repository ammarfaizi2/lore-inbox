Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271809AbRH1QtO>; Tue, 28 Aug 2001 12:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271817AbRH1QtE>; Tue, 28 Aug 2001 12:49:04 -0400
Received: from victor.ndsuk.com ([194.202.59.31]:37897 "EHLO victor.ndsuk.com")
	by vger.kernel.org with ESMTP id <S271809AbRH1Qsz>;
	Tue, 28 Aug 2001 12:48:55 -0400
Message-ID: <F128989C2E99D4119C110002A507409801555EBF@topper.hrow.ndsuk.com>
From: "Elgar, Jeremy" <JElgar@ndsuk.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: RE: NFS Client and SMP
Date: Tue, 28 Aug 2001 17:49:44 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ill force a freeze tonight and check the logs just to check, but as you say
im inclined to suspect some problem with the server.

Cheers.
Jeremy


> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: 28 August 2001 17:48
> To: JElgar@ndsuk.com
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: NFS Client and SMP
> 
> 
> > Copying a large (n>20) number of file from local disk to an 
> nfs share (on
> > the BSD box)
> > causes the server to totally freeze (have to reboot) 
> normally have to bring
> > the local machines nic up and down to get anything back. 
> kill's on the cp's
> > wont do anything
> 
> Whichever end froze is the buggy one. NFS clients are 
> supposed to be robust
> so if Linux was doing something bad the openbsd box should 
> have errored it
> and vice versa. Both may indeed be buggy but the freeze is th efirst
> target.
> 
> Alan
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


