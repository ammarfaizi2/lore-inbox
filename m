Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271109AbRHTLmi>; Mon, 20 Aug 2001 07:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271173AbRHTLm2>; Mon, 20 Aug 2001 07:42:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:5037 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271109AbRHTLmL>;
	Mon, 20 Aug 2001 07:42:11 -0400
Date: Mon, 20 Aug 2001 07:42:24 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andreas Hartmann <andihartmann@freenet.de>,
        Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.8-ac5 and earlier] fatal mount-problem
In-Reply-To: <E15YnGB-0005sr-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0108200732190.1313-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 Aug 2001, Alan Cox wrote:

> > > (as modules) and you do the same mount again on the same (not unmounted)
> > > device, the mount-programm hangs up and never comes back. It doesn't
> > > recognize, that the device is allready mounted.
> > 
> > strace, please. -ac5 and 2.4.9 have the same code in fs/super.c, so

Aha. They actually don't (sorry - I was thinking of 2.4.7-ac5), but...
> > I really wonder what the hell is happening...
> 
> Duplicated here with 2.4.8-ac6
> Booted with ide-scsi as the cd driver

I can't reproduce it with /dev/hda and /dev/hdd (ide-disk and ide-cd resp.)
here. I'll build kernel with ide-scsi and see what's going on with that.

