Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266969AbTBLIEe>; Wed, 12 Feb 2003 03:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbTBLIEd>; Wed, 12 Feb 2003 03:04:33 -0500
Received: from mail.dsa-ac.de ([62.112.80.99]:21767 "HELO k2.dsa-ac.de")
	by vger.kernel.org with SMTP id <S266969AbTBLIEc>;
	Wed, 12 Feb 2003 03:04:32 -0500
Date: Wed, 12 Feb 2003 09:14:15 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.60 "Badness in kobject_register at lib/kobject.c:152"
In-Reply-To: <1044969981.12906.21.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0302120910560.1173-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I reported earlier a problem with getting 2 flash disks to work in
> > true-IDE mode with 2.4.[18|20]
> > (http://www.uwsg.indiana.edu/hypermail/linux/kernel/0302.0/0918.html).
> > Today I tried 2.5.60. Tried with 2 flash-disks and with 1 only. With 2
> > flash-disks connected the kernel panics (notice, hda disappears after the
> > initial detection):
>
> Known problem. Its probably fixed in the 2.4 changes I made to the
> probe and flash bits yesterday. Its two bugs together. The vanishing
> disk is definitely fixed, the oops from drive->id = NULL should be
> sorted too (and the general noprobe, cdrom cases)

Great! Is there a patch available? I still have time until today early
afternoon to fix this... So, a patch would be really highly appreciated!

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

