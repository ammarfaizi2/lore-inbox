Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287860AbSATW4F>; Sun, 20 Jan 2002 17:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288781AbSATWzq>; Sun, 20 Jan 2002 17:55:46 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:34184 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S287860AbSATWzj>; Sun, 20 Jan 2002 17:55:39 -0500
Date: Sun, 20 Jan 2002 15:55:34 -0700
Message-Id: <200201202255.g0KMtYh15207@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Oliver Feiler <kiza@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Removing files in devfs
In-Reply-To: <20020119094424.A239@gmxpro.net>
In-Reply-To: <20020119094424.A239@gmxpro.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Feiler writes:
> Hello,
> 
> 	Is this behaviour supposed to be?
> 
> 9:36 root@kiza /dev# l null 
> crw-rw-rw-    1 root     root       1,   3 Jan  1  1970 null
> 9:36 root@kiza /dev# rm null
> removing `null'
> 9:36 root@kiza /dev# l null
> ls: null: No such file or directory
> 9:36 root@kiza /dev#
> 
> 	I have kernel 2.4.16 with devfs and on every other system I
> tried I only get "rm: cannot unlink `null': Operation not permitted"
> when trying to delete something in devfs. And I cannot see any
> differences as far as devfs is concerned on the systems I
> tried. devfs compiled in, mounted on boot time, same version of
> devfsd.

What is "every other system"?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
