Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSHJMQI>; Sat, 10 Aug 2002 08:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316882AbSHJMQI>; Sat, 10 Aug 2002 08:16:08 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:30393 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316878AbSHJMQH>; Sat, 10 Aug 2002 08:16:07 -0400
Message-Id: <5.1.0.14.2.20020810131745.00b2e320@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 10 Aug 2002 13:20:01 +0100
To: Alexander Viro <viro@math.psu.edu>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: modules missing author name and/or description
Cc: Christian Kurz <shorty@getuid.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0208100758290.9847-100000@weyl.math.psu.edu>
References: <20020810091434.GM23894@salem.getuid.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:04 10/08/02, Alexander Viro wrote:
>On Sat, 10 Aug 2002, Christian Kurz wrote:
> > I just played with lsmod and modinfo and noticed that the following
> > modules which I use either lack one or both of the information I
> > mentioned in the description. The following modules lack the name of the
> > author:
>
>[snip the list]
>
>Quite a few modules don't _have_ a single author.  MODULE_AUTHOR is
>optional and very dubious at that - especially since we already have
>a common way to put attributions in there; just look at the comments
>in the beginning of almost any file in the tree.

Yes, MODULE_MAINTAINER would be way more useful than MODULE_AUTHOR anyway, 
so you know whom to contact about bugs, even when you don't have source 
code at hand to lookup MAINTAINERS file... The original author can be long 
gone and moved onto other things...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

