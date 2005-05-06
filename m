Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVEFNjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVEFNjx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 09:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVEFNjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 09:39:39 -0400
Received: from mail.microway.com ([64.80.227.22]:63146 "EHLO mail.microway.com")
	by vger.kernel.org with ESMTP id S261162AbVEFNjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 09:39:23 -0400
From: Rick Warner <rick@microway.com>
Organization: Microway, Inc.
To: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: very strange issue with sata,<4G Ram, and ext3
Date: Fri, 6 May 2005 09:39:15 -0400
User-Agent: KMail/1.7.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200504281216.08026.rick@microway.com> <200504291045.58893.rick@microway.com> <m364xxtkuw.fsf@defiant.localdomain>
In-Reply-To: <m364xxtkuw.fsf@defiant.localdomain>
Message-Id: <200505060939.15476.rick@microway.com>
X-Sanitizer: Advosys mail filter
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 May 2005 05:37 pm, Krzysztof Halasa wrote:
> Rick Warner <rick@microway.com> writes:
> > This morning, we tried updating to a newer pxelinux (3.07) and had the
> > same results.  We then tried using etherboot with a mknbi tagged image
> > and also had the same results.   Since we are getting the same problem on
> > 3 different motherboards with 2 different network adapters, I have not
> > looked into updating the boot rom on the nics.  Should I?
>
> I remember I had memory corruption problems with an old version of
> Etherboot few years ago. The machines were mostly AMD K6 based,
> network cards were SMC EPIC100 (Etherpower II) and/or RTL 8139.
>
> Memtest86 (downloaded with Etherboot) complained about random errors.
> I think Linux didn't show any such illness.
> This was Etherboot 4.something. Upgrading to 5.something fixed the
> problem.
>
> I suspect you're using Etherboot newer than 4.x though. I'd probably
> give memtest86 loaded from network a try.

We actually run memtest86 from the network regularly.  This cluster had run 
dozens of passes of memtest booted over the network before doing any of this.  
We also did an md5sum of our initrd from the network boot server, and then 
had the initrd do an md5sum of itself on the network boot.  They matched.  
Thanks for the advice though!  I appreciate it.

-- 
Richard Warner
Lead Systems Integrator
Microway, Inc
(508)732-5517
