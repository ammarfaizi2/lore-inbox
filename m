Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265782AbUGZTaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265782AbUGZTaT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 15:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUGZTaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 15:30:18 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:37339 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265841AbUGZSJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 14:09:09 -0400
Date: Mon, 26 Jul 2004 20:09:01 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Ed Sweetman <safemode@comcast.net>
Cc: Jim Gifford <maillist@jg555.com>, "Adam J. Richter" <adam@yggdrasil.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Future devfs plans
Message-ID: <20040726180901.GG11817@fs.tum.de>
References: <200407261445.i6QEjAS04697@freya.yggdrasil.com> <057601c472a3$9df39ac0$d100a8c0@W2RZ8L4S02> <41044DA6.5080501@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41044DA6.5080501@comcast.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 25, 2004 at 08:17:42PM -0400, Ed Sweetman wrote:
>...
> On 
> top of that, MAKEDEV as distributed at least by debian, doesn't create 
> alsa devices and there is no script in the kernel source tree that i've 
> found that allows the device creation.  One would have to go download 
> the alsa-driver package from the alsa-project website and use the 
> snddevices.sh script.  Since alsa-driver is integrated with the kernel 
> now, this device creation script should be included in the kernel source 
> or if that's not the place for such a file, we'll have to get on 
> debian's butt to have MAKEDEV updated to actually support it.



  apt-get install alsa-base


Check

  /var/lib/dpkg/info/alsa-base.postinst

and (surprise, surprise!), you'll note the snddevices script is executed 
when installing the alsa-base package.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

