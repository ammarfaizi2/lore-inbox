Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbUGLUen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUGLUen (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUGLUcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:32:33 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:33238 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262772AbUGLU2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:28:45 -0400
Date: Mon, 12 Jul 2004 22:28:36 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: John Lenz <jelenz@students.wisc.edu>, rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Subject: [2.6 patch] remove outdated reference to Documentation/arm/SA1100/PCMCIA
Message-ID: <20040712202836.GX4701@fs.tum.de>
References: <20040706213645.GP28324@fs.tum.de> <20040707022050.GA23184@hydra.mshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707022050.GA23184@hydra.mshome.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

