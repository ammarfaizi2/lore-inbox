Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbVBCCve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbVBCCve (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 21:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbVBCCve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 21:51:34 -0500
Received: from smtpout.mac.com ([17.250.248.47]:11206 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262412AbVBCCvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 21:51:09 -0500
In-Reply-To: <Pine.LNX.4.62.0502021950040.19812@localhost.localdomain>
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain> <20050203000917.GA12204@digitasaru.net> <Pine.LNX.4.62.0502021950040.19812@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <692795D1-758E-11D9-9D77-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Joseph Pingenot <trelane@digitasaru.net>,
       Patrick Mochel <mochel@digitalimplant.org>,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Please open sysfs symbols to proprietary modules
Date: Wed, 2 Feb 2005 21:50:49 -0500
To: Pavel Roskin <proski@gnu.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 02, 2005, at 20:13, Pavel Roskin wrote:
> OK, then the "insufficiency" is inability to set and get additional
> named variables for network interfaces.
>
> I won't open all details, but suppose I want the bridge to handle
> certain frames in a special way, just like BPDU frames are handled if
> STP is enabled.  There is a hook for that already - see
> br_handle_frame_hook. The proprietary module would just have to
> change it.
>
> What I want it to tell that module what to do with those special
> frames. I also want to get information like what was in the last
> special frame and how many of them have been received.  In other
> words, I want the proprietary module to communicate with userspace.
> Ideally, the userspace application should be a simple shell script,
> so I'm reluctant to use ioctl.

Why don't you just GPL your driver?  It's not like somebody will have
some innate commercial advantage over you because they have your
driver source code.  You might even have a commercial advantage by
participating with GPL drivers because the community will help adjust
them to in-kernel API changes too.  Besides, you'll get cross-platform
portability basically for free, as opposed to a binary-only driver for
x86 where you can't use it on PPC, Alpha, etc.  Please consider the
benefits to GPL software ;-)

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


