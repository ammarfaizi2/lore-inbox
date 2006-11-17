Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755961AbWKQWDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961AbWKQWDA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 17:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755963AbWKQWC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 17:02:59 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:33017 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1755961AbWKQWC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 17:02:59 -0500
From: "Christian Hoffmann" <email@christianhoffmann.info>
To: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>,
       "'Christian Hoffmann'" <chrmhoffmann@gmail.com>
Cc: "'Stuffed Crust'" <pizza@shaftnet.org>,
       "'Rafael J. Wysocki'" <rjw@sisk.pl>,
       <linux-fbdev-devel@lists.sourceforge.net>,
       "'Christian Hoffmann'" <Christian.Hoffmann@wallstreetsystems.com>,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'LKML'" <linux-kernel@vger.kernel.org>,
       "'Pavel Machek'" <pavel@ucw.cz>
Subject: RE: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working onacer ferrari 4005 with radeonfb enabled
Date: Fri, 17 Nov 2006 23:02:34 +0100
Message-ID: <000701c70a94$1d9c2b40$6700a8c0@r2d2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1250"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <1163800768.5826.21.camel@localhost.localdomain>
Thread-Index: AccKk5uUBkOISXgETRKA69+tqPSweAAADizg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:0c70a6aacd88c3d0148ad54724e6d85b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org] 
> Sent: Friday, November 17, 2006 10:59 PM
> To: Christian Hoffmann
> Cc: Stuffed Crust; Rafael J. Wysocki; 
> linux-fbdev-devel@lists.sourceforge.net; Christian Hoffmann; 
> Andrew Morton; LKML; Pavel Machek
> Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume 
> not working onacer ferrari 4005 with radeonfb enabled
> 
> 
> > When I comment out the rinfo->asleep = 0; line, the machine comes 
> > back. So it seems that rinfo struct is still corrupted somehow.
> 
> No, I don't think the rinfo is corrupted, I think the chip is 
> in a state the driver can't cope with. Possibly related to 
> some PCI-Express specific bits or to the memory map.
> 
> At this point, we'll need to do register dumps.

Sorry, but how do I do that? 

Chris

BTW: yes, it's a PCI-express card.

-- 
No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.5.430 / Virus Database: 268.14.6/536 - Release Date: 11/16/2006
3:51 PM
 

