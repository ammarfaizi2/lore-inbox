Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263546AbTKRPJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 10:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTKRPJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 10:09:26 -0500
Received: from host81-152-26-135.range81-152.btcentralplus.com ([81.152.26.135]:20696
	"EHLO cambridge.braddahead.com") by vger.kernel.org with ESMTP
	id S263546AbTKRPJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 10:09:24 -0500
Subject: Re: Userspace DMA
From: Alex Bennee <kernel-hacker@bennee.com>
To: Linux Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Hackers Inc
Message-Id: <1069168156.31133.11.camel@cambridge.braddahead.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Tue, 18 Nov 2003 15:09:17 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now my mailer is fixed :-)

-----Forwarded Message-----
> From: Alex Bennee <kernel-hacker@bennee.com>
> To: Peter Chubb <peter@chubb.wattle.id.au>
> Cc: public@mikl.as, Linux Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: Userspace DMA
> Date: Mon, 17 Nov 2003 10:37:40 +0000
> 
> On Mon, 2003-11-17 at 04:34, Peter Chubb wrote:
> > >>>>> "Andrew" == Andrew Miklas <public@mikl.as> writes:
> > Andrew> Hi, Is there an accepted way of doing userspace DMA with
> > Andrew> Linux?
> > 
> > I'm currently working on a framework for user-space device drivers,
> > that allow suitably privileged user-space programs to set up and tear
> > down dma regions 
> 
> Hi,
> 
> I've also been doing some work on allowing user processes to access the
> DMA hardware facilities of the processor platform. This is not actually
> aimed at pci stuff but used for other devices on the embedded SH board I
> use. It works using a packetised writev interface to send DMA requests
> to kernel space where the mapping of memory is done. It really works
> best with scatter gather dma as user-pages can be spread out all over
> the place.
> 
> Whether there is any overlap between my approach, what your doing and
> what Andrew is looking for I have no idea :-) I'm certainly interested
> in seeing any code if only for ideas.
> 
> You can find an alpha (but working on my system) copy of the code at:
> 
> http://www.bennee.com/~alex/software/kernel/index.php
-- 
Alex, homepage: http://www.bennee.com/~alex/
I used to get high on life but lately I've built up a resistance.

