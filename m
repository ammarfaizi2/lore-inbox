Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313057AbSDJNdV>; Wed, 10 Apr 2002 09:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313062AbSDJNdU>; Wed, 10 Apr 2002 09:33:20 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:51175 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313057AbSDJNdT>; Wed, 10 Apr 2002 09:33:19 -0400
Date: Wed, 10 Apr 2002 14:33:18 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Emmanuel Michon <emmanuel_michon@realmagic.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: module programming smp-safety howto?
In-Reply-To: <7w7knf98gk.fsf@avalon.france.sdesigns.com>
Message-ID: <Pine.SOL.3.96.1020410142815.250A-100000@draco.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Look at Linux Kernel Internals available at:

http://www.moses.uklinux.net/patches/lki.html

Also, are we going to see the driver published under GPL (I sure hope
so!) or is it going to be binary only as per usual Sigma Designs policy?

Anton

On 10 Apr 2002, Emmanuel Michon wrote:

> Hi,
> 
> I'm responsible for the development of a kernel module for Sigma
> Designs EM84xx PCI chips (MPEG2 and MPEG4 hardware decoder
> boards). It's working properly now, irq sharing and multiple board
> support is ok.
> 
> I would like to make it smp-safe.
> 
> For instance, I use at a place cli()/restore to implement something that
> looks like a critical section (first code path is in a ioctl, second
> in a irq top half). I guess this approach is wrong with smp.
> 
> Is there some documentation or howto about what changes compared
> to non-smp computers?
> 
> Maybe a specific kernel module can be considered as a good model?
> 
> Sincerely yours,
> 
> -- 
> Emmanuel Michon
> Chef de projet
> REALmagic France SAS
> Mobile: 0614372733 GPGkeyID: D2997E42  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
IRC: #ntfs on irc.openprojects.net / ICQ: 8561279
WWW: http://www-stu.christs.cam.ac.uk/~aia21/

