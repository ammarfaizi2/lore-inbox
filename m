Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285498AbRLGUJd>; Fri, 7 Dec 2001 15:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285500AbRLGUJS>; Fri, 7 Dec 2001 15:09:18 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:26764 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S285499AbRLGUJM>; Fri, 7 Dec 2001 15:09:12 -0500
Date: Fri, 7 Dec 2001 13:08:43 -0700
Message-Id: <200112072008.fB7K8hA18586@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rene Rebe <rene.rebe@gmx.net>, linux-kernel@vger.kernel.org,
        alsa-devel@lists.sourceforge.net
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] 
 /ALSA-0.9.0beta[9,10]
In-Reply-To: <3C1115CD.FD2858EC@linux-m68k.org>
In-Reply-To: <200112070609.fB769Eo08508@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.33.0112071617440.2935-100000@serv>
	<200112071559.fB7FxwR14021@vindaloo.ras.ucalgary.ca>
	<3C1115CD.FD2858EC@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel writes:
> Hi,
> 
> Richard Gooch wrote:
> 
> > Well, no, it was never a valid option. It was always a bug. In any
> > case, the stricter behaviour isn't preventing people from using their
> > drivers, it's just issuing a warning. The user-space created device
> > node still works.
> 
> But the driver doesn't. You changed the driver API in subtle way!
> You cannot change the behaviour of devfs_register during 2.4. Do
> whatever you want in 2.5, but drivers depend on the current
> behaviour and devfs has to be fixed not these drivers.

Tell me how the driver no longer works. I repeat: you now get a
warning. You can still use the driver.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
