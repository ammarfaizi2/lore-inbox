Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271656AbRH0F6H>; Mon, 27 Aug 2001 01:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271657AbRH0F55>; Mon, 27 Aug 2001 01:57:57 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:43527 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S271656AbRH0F5h>; Mon, 27 Aug 2001 01:57:37 -0400
Message-Id: <200108270557.f7R5vkY71296@aslan.scsiguy.com>
To: "Manfred H. Winter" <mahowi@gmx.net>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.9] aic7xxx modules don't compile 
In-Reply-To: Your message of "Sun, 26 Aug 2001 12:00:18 +0200."
             <20010826120017.A2998@marvin.mahowi.de> 
Date: Sun, 26 Aug 2001 23:57:46 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi!
>
>The compilation of the kernel modules (2.4.9) stops with:
>
>make -C aic7xxx modules
>make[3]: Entering directory `/usr/src/linux-2.4.9/drivers/scsi/aic7xxx'

...

>Is this a known problem?

Did you check the list archives? 8-)

You need to either:

A) cd /usr/src/linux-2.4.89drivers/scsi/aic7xxx/aicasm && make clean

or

B) Turn of "build driver firmware" below the aic7xxx option in your
   kernel config.

Prior to doing this, I would appreciate seeing an:

ls -l /usr/src/linux-2.4.9/drivers/scsi/aic7xxx/aicasm

so I can verify that my fix to the aicasm Makefile will correct your
problem.

--
Justin
