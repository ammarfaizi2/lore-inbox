Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRCOViH>; Thu, 15 Mar 2001 16:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131197AbRCOVh5>; Thu, 15 Mar 2001 16:37:57 -0500
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:36743 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S129143AbRCOVhq>; Thu, 15 Mar 2001 16:37:46 -0500
Date: Thu, 15 Mar 2001 21:40:04 +0000 (GMT)
From: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
To: John Jasen <jjasen@datafoundation.com>
cc: Ted Gervais <ve1drg@ve1drg.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.2
In-Reply-To: <Pine.LNX.4.30.0103151455350.343-100000@flash.datafoundation.com>
Message-ID: <Pine.LNX.4.21.0103152133590.14137-100000@erdos.shef.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do have the latest version of modutils (at least, the one required by
Documentation/Changes - 2.4.2), but I still have to all the line add
path=/lib/modules/`uname -r`/kernel/* to /etc/modules.conf. 
ONLY then it works. At least it worked until yesterday... Yesterday I
found out that I can't use CD-ROM on one of the machines, and, in
particular, when I am trying to access it - together with ide.o,
iso9660.o, also get loaded lp.o, parport.o and parport-pc.o... with no
visible reason... But I am not sure if this should be associated with
modutils or whatever... Why did I need that line?

Thanks
Guennadi

On Thu, 15 Mar 2001, John Jasen wrote:

> On Thu, 15 Mar 2001, Ted Gervais wrote:
> 
> > Anyways - to get things to work, I have put added this statement to the
> > top of my /etc/rc.d/rc.inet1 file:
> >
> > insmod /usr/src/linux/drivers/net/8139too.o.
> 
> install a later version of modutils, as the /lib/modules directory tree
> has changed between 2.2.x and 2.4.x
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

___

Dr. Guennadi V. Liakhovetski
Department of Applied Mathematics
University of Sheffield, U.K.
email: G.Liakhovetski@sheffield.ac.uk


