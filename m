Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSIDSRE>; Wed, 4 Sep 2002 14:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSIDSRE>; Wed, 4 Sep 2002 14:17:04 -0400
Received: from cats-mx1.ucsc.edu ([128.114.129.36]:41171 "EHLO cats.ucsc.edu")
	by vger.kernel.org with ESMTP id <S314138AbSIDSRC>;
	Wed, 4 Sep 2002 14:17:02 -0400
Subject: 3 ultra100 controllers
From: "T. Ryan Halwachs" <halwachs@cats.ucsc.edu>
To: kernel mailing list <linux-kernel@vger.kernel.org>,
       ataraid mailing list <ataraid-list@redhat.com>, andre@linux-ide.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Sep 2002 11:19:50 -0700
Message-Id: <1031163605.4320.41.camel@p700m700>
Mime-Version: 1.0
X-UCSC-CATS-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sent this to promise:

> -----Original Message-----
> From: T. Ryan Halwachs [mailto:halwachs@cats.ucsc.edu] 
> Sent: Monday, August 26, 2002 4:18 PM
> To: support@promise.com
> Subject: 3 ultra100 controllers
> 
> 
> hi,
>  i am trying to use three Promise technology controllers in one system.
> the promise bios only shows drives attached to the first 2 controllers.
> how can i use the drives attached to the third controller?
> 
> cheers,
> ryan
> 
> 
> 

got this in reply:

> From: support <support@promise.com>
> To: 'T. Ryan Halwachs' <halwachs@cats.ucsc.edu>
> Subject: RE: 3 ultra100 controllers
> Date: 28 Aug 2002 08:23:29 -0700
> 
> Hi Ryan
> 	Sorry you will not be able to used 3 ultra100 in single system.
> 2 is the most.
> 
> It's All About Your Data!
> 
> Kevin Huynh
> Reseller Technical Support.
> Promise Technology, Inc
> 1745 McCandless Dr.
> Milpitas Ca, 95035
> 408-228-6300
> 
> 

from pdc202xx.c in 2.4.19-ac4

/* 
*  linux/drivers/ide/pdc202xx.c	Version 0.35	Mar. 30, 2002 
* 
*  Copyright (C) 1998-2002		Andre Hedrick <andre@linux-ide.org> 
* 
*  Promise Ultra33 cards with BIOS v1.20 through 1.28 will need this 
*  compiled into the kernel if you have more than one card installed. 
*  Note that BIOS v1.29 is reported to fix the problem.  Since this is 
*  safe chipset tuning, including this support is harmless 
* 
*  Promise Ultra66 cards with BIOS v1.11 this 
*  compiled into the kernel if you have more than one card installed. 
* 
*  Promise Ultra100 cards. 
* 
*  The latest chipset code will support the following :: 
*  Three Ultra33 controllers and 12 drives. 
*  8 are UDMA supported and 4 are limited to DMA mode 2 multi-word. 
*  The 8/4 ratio is a BIOS code limit by promise. 
* 
*  UNLESS you enable "CONFIG_PDC202XX_BURST" 
* 
*/

is it possible (using Linux) to run 3 (or more) PDC20267 based ultra100 cards in the same machine?

cheers,
ryan

