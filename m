Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbTI3MGe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbTI3MGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:06:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5600 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261373AbTI3MG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:06:29 -0400
Date: Tue, 30 Sep 2003 14:06:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Message-ID: <20030930120629.GM2908@suse.de>
References: <200309301157.h8UBvOcd004345@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309301157.h8UBvOcd004345@burner.fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30 2003, Joerg Schilling wrote:
> 
> >From axboe@suse.de  Tue Sep 30 13:54:12 2003
> 
> >> >> Is there no interest in user applications for kernel features or is there just
> >> >> no kernel maintainer left over who makes the needed work?
> >> 
> >> >/usr/include/scsi/scsi.h looks fine on my system, probably also on
> >> >yours. You should not include kernel headers in your user space program.
> >> 
> >> Looks like you did not understand the background :-(
> 
> >I think I do.
> 
> Sorry, but you just verified that you don't :-(

No, you continue to show you don't understand why you should not include
kernel headers in user space.

> >> In order to use kernel interfaces you _need_ to include kernel include
> >> files.
> 
> >False. You need to include the glibc kernel headers.
> 
> 
> False: as glibc kernel headers are not part of the kernel distribution.

How is that an argument? By your logic, you need one huge package with
basically everything in it, how else do you know your application works
with that given kernel?

I asked you one simple question: when did the kernel/user interface
break, and how? You happily chose to ignore that. A pity, since that
would be the core of your argument.

I'm not saying that situation _never_ happened, but it is an extremely
rare event and usually only happens for a very good reason. When did you
last need to recompile a program because you upgraded your kernel?

> >> This is in particular true as long as we are talking about
> >> beta/testing kernels.
> >> 
> >> 
> >> Background: on homogeneous platforms like e.g. Solaris or FreeBSD
> >> which are maintained and distributed as whole, an _enduser_ should
> >> include files from /usr/include only. 
> >> 
> >> 	This is not even true for people who do Solaris or FreeBSD
> >> 	kernel development and like to test new features with user level
> >> 	programs.  It is definitely not true for compilations against
> >> 	Linux kernel interfaces.
> >> 
> >> Linux is not a homogeneous system. There is a separately developed
> >> kernel and a separate base user level system. People often install a
> >> newer kernel and need to recompile software because the kernel/user
> >> interfaces are not stable between different Linux releases.
> 
> >That's a pretty bold claim, when did the kernel/user interface break? A
> >lot of care is usually taken to ensure that this does not happen.
> 
> >This subject has been debated to death lots of times before, I'm sure
> >the archives are more detailed and enlightening that I am.
> 
> If these debates have not been done in a serious way, or people without
> the needed kernel development background knowledge did decide, these
> debates are just void.

Did you search and find these debates? Or are you just assuming you know
better?

-- 
Jens Axboe

