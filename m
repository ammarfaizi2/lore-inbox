Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTKBVk6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 16:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTKBVk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 16:40:58 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:6159 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S261837AbTKBVk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 16:40:57 -0500
Date: Sun, 2 Nov 2003 22:40:51 +0100
From: DervishD <raul@pleyades.net>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Using proc in chroot environments
Message-ID: <20031102214051.GC54@DervishD>
References: <20031102204934.GB54@DervishD> <20031102210320.GP4868@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031102210320.GP4868@niksula.cs.hut.fi>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Ville :)

 * Ville Herva <vherva@niksula.hut.fi> dixit:
> >     - I must mount copies of devpts, usbfs, etc... under the 'second'
> > proc, too, and this is even more annoying.
> Mount them under /.../chroot/proc ? Hm.

    That's what I'm doing right now (well I mount them under the /dev
directory of the chroot environment ;)
  
> >     The perfect solution for me is to hardlink the proc directory of
> > the chrooted environment to the proc directory on the true root dir,
> > but since this is not possible, whan can I do instead of remounting a
> > second copy of proc (which, by the way, makes /proc/mounts a little
> > bit weird...)?
> mount --bind is closest to hardlink you can get and it works. But I don't
> know if that is that much different from mounting proc second time.

    For other filesystems I don't know, for proc is more or less the
same, except maybe that --bind maybe doesn't show proc mounted twice
:???

    Thanks :))

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
