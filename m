Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267822AbUG3UH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267822AbUG3UH5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 16:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267819AbUG3UH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 16:07:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:56028 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267816AbUG3UGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 16:06:48 -0400
Date: Fri, 30 Jul 2004 22:06:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: John Lenz <jelenz@students.wisc.edu>, rmk@arm.linux.org.uk,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Subject: [2.6 patch] remove outdated reference to Documentation/arm/SA1100/PCMCIA (fwd)
Message-ID: <20040730200641.GB2746@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI:
The trivial patch forwarded below still applies against 2.6.8-rc2-mm1.


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Mon, 12 Jul 2004 22:28:36 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: John Lenz <jelenz@students.wisc.edu>, rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Subject: [2.6 patch] remove outdated reference to Documentation/arm/SA1100/PCMCIA

On Tue, Jul 06, 2004 at 09:20:50PM -0500, John Lenz wrote:
> > diff -up old-doc-2.5/drivers/pcmcia/sa1100_generic.c doc-2.5/drivers/pcmcia/sa1100_generic.c
> > --- old-doc-2.5/drivers/pcmcia/sa1100_generic.c	Fri Jan  9 17:27:47 2004
> > +++ doc-2.5/drivers/pcmcia/sa1100_generic.c	Fri Jan  9 18:14:20 2004
> > @@ -30,7 +30,7 @@
> >      
> >  ======================================================================*/
> >  /*
> > - * Please see linux/Documentation/arm/SA1100/PCMCIA for more information
> > + * Please see Documentation/arm/SA1100/PCMCIA for more information
> >   * on the low-level kernel interface.
> >   */
> >  
> 
> This file does not exist in 2.6.  It exists in 2.4.  I believe the documentation file
> was removed because in 2.5 the interface changed but the documentation was never 
> updated.  This entire comment should just be removed.


Patch below.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm7-full/drivers/pcmcia/sa1100_generic.c.old	2004-07-12 22:25:44.000000000 +0200
+++ linux-2.6.7-mm7-full/drivers/pcmcia/sa1100_generic.c	2004-07-12 22:26:36.000000000 +0200
@@ -29,10 +29,6 @@
     file under either the MPL or the GPL.
     
 ======================================================================*/
-/*
- * Please see linux/Documentation/arm/SA1100/PCMCIA for more information
- * on the low-level kernel interface.
- */
 
 #include <linux/module.h>
 #include <linux/init.h>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----


