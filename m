Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUGGCSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUGGCSM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 22:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264815AbUGGCSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 22:18:12 -0400
Received: from heimdall.doit.wisc.edu ([144.92.197.159]:40835 "EHLO
	smtp5.wiscmail.wisc.edu") by vger.kernel.org with ESMTP
	id S264791AbUGGCSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 22:18:10 -0400
Date: Tue, 06 Jul 2004 21:20:50 -0500
From: John Lenz <jelenz@students.wisc.edu>
Subject: Re: [2.6 patch] Canonically reference files in Documentation/ code
 comments part
In-reply-to: <20040706213645.GP28324@fs.tum.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org,
       Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>
Message-id: <20040707022050.GA23184@hydra.mshome.net>
MIME-version: 1.0
X-Mailer: Balsa 2.0.17
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Spam-Score: 
X-Spam-Report: IsSpam=no, TrustedSender=yes, SenderIP=128.105.111.115,
 Server=avs-1, Version=4.6.0.99824, Antispam-Core: 4.6.1.104326,
 Antispam-Data: 2004.7.6.106122
References: <20040706213645.GP28324@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -up old-doc-2.5/drivers/pcmcia/sa1100_generic.c doc-2.5/drivers/pcmcia/sa1100_generic.c
> --- old-doc-2.5/drivers/pcmcia/sa1100_generic.c	Fri Jan  9 17:27:47 2004
> +++ doc-2.5/drivers/pcmcia/sa1100_generic.c	Fri Jan  9 18:14:20 2004
> @@ -30,7 +30,7 @@
>      
>  ======================================================================*/
>  /*
> - * Please see linux/Documentation/arm/SA1100/PCMCIA for more information
> + * Please see Documentation/arm/SA1100/PCMCIA for more information
>   * on the low-level kernel interface.
>   */
>  

This file does not exist in 2.6.  It exists in 2.4.  I believe the documentation file
was removed because in 2.5 the interface changed but the documentation was never 
updated.  This entire comment should just be removed.
