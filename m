Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUIDW1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUIDW1y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 18:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUIDW1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 18:27:54 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:19125 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263893AbUIDW1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 18:27:52 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: multi-domain PCI and sysfs
Date: Sat, 4 Sep 2004 15:27:50 -0700
User-Agent: KMail/1.7
Cc: lkml <linux-kernel@vger.kernel.org>
References: <9e4733910409041300139dabe0@mail.gmail.com> <200409041457.46578.jbarnes@engr.sgi.com> <9e47339104090415123750a1eb@mail.gmail.com>
In-Reply-To: <9e47339104090415123750a1eb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409041527.50136.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, September 4, 2004 3:12 pm, Jon Smirl wrote:
> On Sat, 4 Sep 2004 14:57:46 -0700, Jesse Barnes <jbarnes@engr.sgi.com> 
wrote:
> > Yep, on all the machines I've used.
> >
> > sn2 (ia64):
> > [root@flatearth ~]# ls -l /sys/devices
> > total 0
> > drwxr-xr-x  5 root root 0 Sep  5 08:07 pci0000:01
> > drwxr-xr-x  3 root root 0 Sep  5 08:07 pci0000:02
> > drwxr-xr-x  2 root root 0 Sep  5 08:07 platform
> > drwxr-xr-x  5 root root 0 Sep  5 08:07 system
>
> sn2 looks wrong. It should be
>
> > drwxr-xr-x  5 root root 0 Sep  5 08:07 pci0000:01
> > drwxr-xr-x  3 root root 0 Sep  5 08:07 pci0001:02
> > drwxr-xr-x  2 root root 0 Sep  5 08:07 platform
> > drwxr-xr-x  5 root root 0 Sep  5 08:07 system

It only has one domain though, so it's correct.  Both busses are in domain 0.

Jesse
