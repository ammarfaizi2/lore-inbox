Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266751AbTGKU2s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266774AbTGKU2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:28:48 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:4364 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S266751AbTGKU2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:28:45 -0400
Date: Fri, 11 Jul 2003 22:43:26 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711204326.GC20970@win.tue.nl>
References: <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk> <Pine.SOL.4.30.0307111646470.9740-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0307111646470.9740-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 04:55:39PM +0200, Bartlomiej Zolnierkiewicz wrote:

> > > - IDE disk geometry translators like OnTrack, EZ Partition, Disk Manager
> > >   are no longer supported. The only way forward is to remove the translator
> > >   from the drive, and start over.
> >
> > Or to use device mapper to remap the disk.
> 
> "hdx=remap" and "hdx=remap63" boot options can be used.
> Or can I remove them?

No.
Distributions will I suppose use the device mapper, and individuals
will add a boot parameter. That is easiest.
It is bad enough that people will have to figure this out,
but there is no reason to make people's life more miserable.

Andries

