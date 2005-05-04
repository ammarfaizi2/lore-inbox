Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVEDTa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVEDTa2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 15:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVEDTa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 15:30:27 -0400
Received: from mail.microway.com ([64.80.227.22]:8130 "EHLO mail.microway.com")
	by vger.kernel.org with ESMTP id S261424AbVEDTaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 15:30:00 -0400
From: Rick Warner <rick@microway.com>
Organization: Microway, Inc.
To: linux-kernel@vger.kernel.org
Subject: Re: very strange issue with sata,<4G Ram, and ext3
Date: Wed, 4 May 2005 15:29:54 -0400
User-Agent: KMail/1.7.2
References: <200504281216.08026.rick@microway.com> <1114728503.24687.248.camel@localhost.localdomain> <200504291045.58893.rick@microway.com>
In-Reply-To: <200504291045.58893.rick@microway.com>
Message-Id: <200505041529.54502.rick@microway.com>
X-Sanitizer: Advosys mail filter
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just sending out a ping on this.. anyone have any ideas?

On Friday 29 April 2005 10:45 am, you wrote:
> On Thursday 28 April 2005 06:48 pm, Alan Cox wrote:
> > On Iau, 2005-04-28 at 17:16, Rick Warner wrote:
> > >  On these systems, we are getting ext2 errors from the initrd during
> > > the untarring.  Soon after, we start getting seg faults on random
> > > things (looks like stuff caused by the still running dhcp client), and
> > > then a continuous stream of segfaults on the restore script itself
> > > (restore[1]).
> >
> > This sounds almost like the pxe/boot code is still using ram that the
> > kernel has now used (eg the PXE layer or pxe booter forgot to close the
> > client and
> > its still DMAing happily into the kernel)
>
> This morning, we tried updating to a newer pxelinux (3.07) and had the same
> results.  We then tried using etherboot with a mknbi tagged image and also
> had the same results.   Since we are getting the same problem on 3
> different motherboards with 2 different network adapters, I have not looked
> into updating the boot rom on the nics.  Should I?
>
> What should I look into next?  I have attached a serial console log of the
> system and errors.  The slashes and pipes you see are from a spinning bar
> thing.  If you want output that is cleaned up without that, I can provide
> it.

-- 
Richard Warner
Lead Systems Integrator
Microway, Inc
(508)732-5517
