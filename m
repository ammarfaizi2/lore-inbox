Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbVCDKAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbVCDKAF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 05:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVCDJ7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 04:59:44 -0500
Received: from as1.cineca.com ([130.186.84.251]:234 "EHLO as1.cineca.com")
	by vger.kernel.org with ESMTP id S262717AbVCDJ6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 04:58:46 -0500
Message-ID: <1109930313.42283149b4ae6@posta.studio.unibo.it>
Date: Fri,  4 Mar 2005 10:58:33 +0100
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: status of the USB w9968cf.c driver in kernel 2.6?
References: <20050228231430.GW4021@stusta.de> <1109699163.4224aa5b1e4dc@posta.studio.unibo.it> <20050303152908.GC4608@stusta.de>
In-Reply-To: <20050303152908.GC4608@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 137.204.58.104
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scrive Adrian Bunk <bunk@stusta.de>:

> On Tue, Mar 01, 2005 at 06:46:03PM +0100, Luca Risolia wrote:
> > Scrive Adrian Bunk <bunk@stusta.de>: 
> >  
> > > I noticed the following regarding the drivers/usb/media/ov511.c driver: 
> >                                                           ^^^^^^^ 
> > > - it's not updated compared to upstream: 
> >  
> > Could you provide more details? 
> 
> Sorry, my fault.
> I confused this with a different driver.
> 
> > > - there's no w9968cf-vpp module in the kernel sources 
> >  
> > w9968cf-vpp is an optional, gpl'ed module, which can not be included in the
> 
> > mainline kernel, as I explained in the documentation of the driver. 
> 
>   Please keep in mind that official kernels do not include the second 
>   module for performance purposes.
> 
> What exactly does this mean?

Frame decoding/decompression should be done in userspace, although you can 
still download and use a separate kernel module.

> 
> Is it useful or not?

Yes

Regards,
Luca


