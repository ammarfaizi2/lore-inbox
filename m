Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292444AbSBZRiV>; Tue, 26 Feb 2002 12:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292429AbSBZRiL>; Tue, 26 Feb 2002 12:38:11 -0500
Received: from montreal.eicon.com ([192.219.17.120]:19719 "EHLO
	mtl_exchange.eicon.com") by vger.kernel.org with ESMTP
	id <S292421AbSBZRiC>; Tue, 26 Feb 2002 12:38:02 -0500
Message-ID: <D8E12241B029D411A3A300805FE6A2B9025761AB@montreal.eicon.com>
From: Daniel Shane <daniel.shane@eicon.com>
To: "'Stelian Pop'" <stelian.pop@fr.alcove.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: PCI driver in userspace
Date: Tue, 26 Feb 2002 12:42:26 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.0.1460.8)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stelian!

I think this is a good example to start with. It has all the
interresting features. I hope it also has interrupt handling
to userspace (by generating SIGIO's). Although I dont know
if this is a good idea in the first place.

Daniel Shane

> On Tue, Feb 26, 2002 at 09:55:48AM -0500, Daniel Shane wrote:
> 
> > I'm looking for an example of userspace PCI driver, does 
> anyone know where I
> > could find one? (Probably not in the kernel source tree, obviously).
> 
> There are probably better examples than mines, but you can still
> look at the Andrew Tridgell's 'capture' application which drives the
> PCI Motion Eye Camera device (and compare with 
> drivers/media/video/meye.c):
> 	http://samba.org/picturebook/
> 
> You'll find in it quite a number of features, including i/o memory
> mapping, i/o port access, etc.
> 
> Of course, one could also direct you to the XFree source code... :-)
> 
> Stelian.
> -- 
> Stelian Pop <stelian.pop@fr.alcove.com>
> Alcove - http://www.alcove.com
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
