Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbVFHImd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVFHImd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 04:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVFHImd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 04:42:33 -0400
Received: from web25805.mail.ukl.yahoo.com ([217.12.10.190]:40085 "HELO
	web25805.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262128AbVFHIm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 04:42:28 -0400
Message-ID: <20050608084224.53355.qmail@web25805.mail.ukl.yahoo.com>
Date: Wed, 8 Jun 2005 10:42:24 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: Advices for a lcd driver design. (suite)
To: Lukasz Stelmach <stlman@poczta.fm>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <42A604AA.2090907@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Lukasz Stelmach <stlman@poczta.fm> a écrit :

> moreau francis napisaÅ‚(a):
> 
> > well I already looked at framebuffers and choose to not use them because
> > t6963c controller does not have a frame buffer memory that can be accessed
> > by using mmap.
> [...]
> > am I wrong in my choice ?
> 
> I think the "buffer" could be shadowed in kernel and updated periodically.
>

Ok I can try using frame buffer, but I'm afraid to use such code for such
small graphic device. Maybe for the start I can forget use "mmap" and use only
"write" method ?
Do you know if I can find an example in kernel code for such implementation ?
 
> 
> Yes and no. No because framebuffer is about drawing graphics not text
> and yest for there is fbcon console driver on top of the framebuffer. At
> least AFAIK.
> 

does that mean once there is fbcon console driver set up on top of framebuffer
I can't use anymore /dev/fb for drawing graphics ?

> BTW, have you seen these
> http://www.skippari.net/lcd/t6963c_prog.html
> http://wwwthep.physik.uni-mainz.de/~frink/lcd-t6963c-0.1/README.html
> 

yeah, but there's only one driver that uses text console implementation
and it can't be accessed for drawing graphics.

thanks

           Francis


	

	
		
_____________________________________________________________________________ 
Découvrez le nouveau Yahoo! Mail : 1 Go d'espace de stockage pour vos mails, photos et vidéos ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com
