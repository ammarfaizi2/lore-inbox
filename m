Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266997AbRGYWEo>; Wed, 25 Jul 2001 18:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267046AbRGYWEe>; Wed, 25 Jul 2001 18:04:34 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:47488 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266997AbRGYWE0>;
	Wed, 25 Jul 2001 18:04:26 -0400
Message-ID: <3B5F428F.14DCAA44@mandrakesoft.com>
Date: Wed, 25 Jul 2001 18:05:03 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: john@vnet.ibm.com, LINUX-KERNEL@vger.kernel.org
Subject: Re: Reserving large amounts of RAM for busmastering PCI card.
In-Reply-To: <mailman.996053899.5490.linux-kernel2news@redhat.com> <200107252200.f6PM0IJ01020@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Pete Zaitcev wrote:
> 
> >  Since the 2.4 kernels introduce the e820map structure, I'd like to
> >  plug into that infrastructure, and create a new type memory segment
> >  for this storage (I envisage having more than one segment), but in the
> >  2.4.4 kernel (which I am forced to remain with for quite a while) it
> >  seems not to be used apart from set up at boot time.
> 
> Stop reinventing the wheel and take Matt & Pauline's bigphisarea.
>  http://www.polyware.nl/~middelink/patch/bigphysarea-2.4.4.tar.gz

Is bigphysarea needed in 2.4?   You have alloc_bootmem...

-- 
Jeff Garzik      | "I use Mandrake Linux for the same reason I turn
Building 1024    |  the light switch on and off 17 times before leaving
MandrakeSoft     |  the room.... If I don't my family will die."
                 |            -- slashdot.org comment
