Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132802AbRDIRSp>; Mon, 9 Apr 2001 13:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132803AbRDIRSf>; Mon, 9 Apr 2001 13:18:35 -0400
Received: from mnh-1-06.mv.com ([207.22.10.38]:58887 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S132802AbRDIRSY>;
	Mon, 9 Apr 2001 13:18:24 -0400
Message-Id: <200104091830.NAA03017@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: schwidefsky@de.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer ! 
In-Reply-To: Your message of "Mon, 09 Apr 2001 17:54:37 +0200."
             <C1256A29.00575FA2.00@d12mta07.de.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 09 Apr 2001 13:30:34 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

schwidefsky@de.ibm.com said:
> I have a suggestion that might seem unusual at first but it is
> important for Linux on S/390. We are facing the problem that we want
> to start many (> 1000) Linux images on a big S/390 machine. Every
> image has its own 100 HZ timer on every processor the images uses
> (normally 1). On a single image system the processor use of the 100 HZ
> timer is not a big deal but with > 1000 images you need a lot of
> processing power just to execute the 100 HZ timers. You quickly end up
> with 100% CPU only for the timer interrupts of otherwise idle images.

This is going to be a problem for UML as well, and I was considering something 
very similar.  I did a quick scan of your prose, and the description sounds 
like what I had in mind.

So, count me in as a supporter of this.

A small request: Since S/390 is not the only port that needs this, I'd be 
happy if it was made as generic as possible (and it may already be, I haven't 
gone through the code yet).

				Jeff


