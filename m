Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbVLODd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbVLODd1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 22:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbVLODd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 22:33:26 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:48351 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1161003AbVLODd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 22:33:26 -0500
Date: Thu, 15 Dec 2005 04:33:24 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linux-VServer ML <vserver@list.linux-vserver.org>
Subject: Re: [ANNOUNCE] second stable release of Linux-VServer
Message-ID: <20051215033324.GA15047@MAIL.13thfloor.at>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux-VServer ML <vserver@list.linux-vserver.org>
References: <20051213185650.GA6466@MAIL.13thfloor.at> <Pine.LNX.4.63.0512140832200.2723@cuia.boston.redhat.com> <43A0AD68.50107@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A0AD68.50107@tmr.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 06:40:24PM -0500, Bill Davidsen wrote:
> Rik van Riel wrote:
> >On Tue, 13 Dec 2005, Herbert Poetzl wrote:
> >
> >>Well, as the OpenVZ folks announced their release on LKML
> >>I just decided to do similar for the Linux-VServer release,
> >>so please let me know if that is not considered appropriate.
> >
> >Since there is a legitimate (and very popular) use case for
> >virtuozzo / vserver functionality, I think it is a good
> >thing to get all the code out in the open.
> >
> >I really hope we will get something like BSD jail functionality
> >in the Linux kernel.  It makes perfect sense for hosting
> >environments.
> >
> Like many needs there are lots of solutions, none of which are perfect, 
> or at least without problems the competition says are important ;-) This 
> is one more thing to study, but it seems as though there is not an 
> overview of the various solutions for easy comparison.
> 
> This list is probably incomplete:
>  linuxjail - BSD jail is the goal
>  VMware - I use this for BSD machines
>  xen - the last I looked ran Linux, not Windows or BSD unpatched
>  UML - run Linux nicely
>  VServer - news to me

free:				commercial:

Virtual Machine (Emulators/Simulators):
(allows for unmodified guest systems)

 - Bochs			 - VMware
 - QEMU				 - SoftPC
 - Hercules			 - VirtualPC
 - GXemul
 - UAE

Para Virtualization (Hypervisor)
(requires modified guest kernels, without HW support)

 - IBM Hypervisor		 - VMware ESX
 - Xen				 - TRANGO
 - UML

Kernel Isolation (Partitioning)
(does not support guest kernels at all)

 - Linux-VServer		 - Virtuozzo
 - FreeVPS			 
 - OpenVZ
 - linuxjails

best,
Herbert

PS: please add stuff where appropriate ...
(not considered to be a complete list)

> 
> -- 
>    -bill davidsen (davidsen@tmr.com)
> "The secret to procrastination is to put things off until the
>  last possible moment - but no longer"  -me
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
