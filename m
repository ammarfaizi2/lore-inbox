Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWGUV1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWGUV1c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 17:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWGUV1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 17:27:31 -0400
Received: from compunauta.com ([69.36.170.169]:19144 "EHLO compunauta.com")
	by vger.kernel.org with ESMTP id S1751197AbWGUV1b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 17:27:31 -0400
From: Gustavo Guillermo =?iso-8859-1?q?P=E9rez?= 
	<gustavo@compunauta.com>
Organization: www.compunauta.com
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] devfs is obsolete, but dbus/hald/ivman does not spend more resources at boot time?
Date: Fri, 21 Jul 2006 00:38:31 -0500
User-Agent: KMail/1.8.2
References: <200607181211.32092.gustavo@compunauta.com> <20060718175959.GA9311@kroah.com>
In-Reply-To: <20060718175959.GA9311@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607210038.31902.gustavo@compunauta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Martes, 18 de Julio de 2006 12:59, escribió:
> On Tue, Jul 18, 2006 at 12:11:31PM -0500, Gustavo Guillermo P?rez wrote:
> > I was used to mount devfs in a separate folder, to search for a ZISO file
> > on hard drives or DVD/CD units in my boot ram rescue disks, and Gentoo
> > live DVD, in last kernel versions devfs still there but not anymore in
> > config, we still able to use it, touching some files.
> >
> > Just to know ?How many releases will still there?
>
> devfs has been fully removed from the kernel for 2.6.18, but had been
> disabled and really not working at all since 2.6.13, which has been for
> a year now.
True, but for hard drives and CD units works fine
> > How do you a search for drives with hald/dbus at boot time on a ramdisk
> > it is not more complex?!?!?!.
>
> What exactly are you trying to do?  Look at /sys/block/ for all block
> devices in the system.
Yes there are the block devices and partitions but I'm not sure if removable=1 
means CDROM...
> If you want to do it in a more portable and cross-OS way, use HAL, and ask 
> those developers on how to do it. 
I guess, ok, I'll give a try to hal, and I see I can use too 
the /sys/block/*/dev info to make nodes, and would be the same, cause is just 
for probing media and looking for a big file with the system, when the system 
is found, dbus/hal/ivman take scene.
> thanks,
Thanks to you.
> greg k-h

-- 
Gustavo Guillermo Pérez
Compunauta uLinux
www.compunauta.com
