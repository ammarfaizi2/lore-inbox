Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314596AbSEYNvN>; Sat, 25 May 2002 09:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314602AbSEYNvM>; Sat, 25 May 2002 09:51:12 -0400
Received: from jwhite-home.codeweavers.com ([209.240.253.22]:31088 "EHLO
	jwhiteh.whitesen.org") by vger.kernel.org with ESMTP
	id <S314600AbSEYNvL>; Sat, 25 May 2002 09:51:11 -0400
Subject: Re: isofs unhide option:  troubles with Wine
From: Jeremy White <jwhite@codeweavers.com>
To: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87vg9c49xd.fsf@goat.bogus.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 25 May 2002 08:49:55 -0500
Message-Id: <1022334596.1262.6.camel@jwhiteh>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >     1.  Invert the logic of the option, make it 'hide' instead
> >         of unhide, and so unhide is the default.
> 
> how about:
> 
> /dev/hdb /cdrom iso9660 defaults,ro,unhide,user 0 2
> 
> in your /etc/fstab. This would allow users to mount and unmount CDs.
> It also changes the default to unhide.

Yes, that is what we have to do now.  So, when our product is
installed, a user is presented with a confusing, and highly technical
question, the gist of which is:  please give us your root password
so we can do something you don't understand.  It's okay, trust us,
really...<grin>

Further, I would argue that if you accept that unhide is a
reasonable default for me to force into the fstab, then
it is a reasonable default for the kernel to have.

Cheers,

Jeremy

