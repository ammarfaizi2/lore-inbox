Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266795AbRGLVzq>; Thu, 12 Jul 2001 17:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbRGLVzi>; Thu, 12 Jul 2001 17:55:38 -0400
Received: from merlin.giref.ulaval.ca ([132.203.7.100]:23690 "HELO
	merlin.giref.ulaval.ca") by vger.kernel.org with SMTP
	id <S266867AbRGLVz0>; Thu, 12 Jul 2001 17:55:26 -0400
Message-ID: <3B4E1C83.D4E1E738@giref.ulaval.ca>
Date: Thu, 12 Jul 2001 17:54:11 -0400
From: Luc Lalonde <llalonde@giref.ulaval.ca>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Adaptec SCSI driver lockups
In-Reply-To: <200107122132.f6CLWRU61362@aslan.scsiguy.com>
Content-Type: multipart/mixed;
 boundary="------------F4FDB4151A64666408EB250B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F4FDB4151A64666408EB250B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Justin and Alan,

There was some garbage printed to the /var/log/messages before the
lockup but it is unreadable.

I'll have to read up on how to connect a serial console to this
machine.  It's our main server (YPserver, mail, http, etc) so I don't
want to use it as a test system.  If I use the append="aic7xxx=verbose"
in my lilo.conf will it log extra messages in /var/log/messages?  If so,
will it be useful enough to figure out what the problem is?

Alan,

Wasn't the old_aic7xxx the default driver up to 2.4.5?  If so I don't
know how using the old driver would help since I had the same problems
with 2.4.[2,3,4].  Unless there was some other stuff that has been fixed
that would cause similar problems.

Cheers.


"Justin T. Gibbs" wrote:
> 
> >Hello folks,
> >
> >I'm having trouble identifying wether I'm having hardware or software(
> >OS ) problems.  For the past couple of Months I've been having system
> >lockups every 10 days or so.
> 
> Are there any kernel messages printed prior to the lockup?
> Please attach a serial cable to another machine, enable serial console
> support, run with aic7xxx=verbose, and log all console activity remotely.
> 
> --
> Justin

-- 
Luc Lalonde, Responsable du reseau GIREF

Telephone: (418) 656-2131 poste 6623
Courriel: llalonde@giref.ulaval.ca
--------------F4FDB4151A64666408EB250B
Content-Type: text/x-vcard; charset=us-ascii;
 name="llalonde.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Luc Lalonde
Content-Disposition: attachment;
 filename="llalonde.vcf"

begin:vcard 
n:Lalonde;Luc
x-mozilla-html:FALSE
org:Universite Laval;GIREF
adr:;;;;;;
version:2.1
email;internet:llalonde@giref.ulaval.ca
title:Administateur de reseau
x-mozilla-cpt:;0
fn:Luc Lalonde
end:vcard

--------------F4FDB4151A64666408EB250B--

