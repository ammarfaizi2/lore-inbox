Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265128AbRGENBA>; Thu, 5 Jul 2001 09:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265130AbRGENAx>; Thu, 5 Jul 2001 09:00:53 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:12294 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S265128AbRGENAe>; Thu, 5 Jul 2001 09:00:34 -0400
Date: Thu, 5 Jul 2001 14:56:26 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Cyril ADRIAN <c.adrian@alplog.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbols since 2.4.5 ?
Message-ID: <20010705145626.L30999@arthur.ubicom.tudelft.nl>
In-Reply-To: <873d8b4kve.fsf@galaxie.alplog.net> <20010705143944.J30999@arthur.ubicom.tudelft.nl> <87wv5n35jf.fsf@galaxie.alplog.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87wv5n35jf.fsf@galaxie.alplog.net>; from c.adrian@alplog.fr on Thu, Jul 05, 2001 at 02:48:52PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 02:48:52PM +0200, Cyril ADRIAN wrote:
> >>>>> "Erik" == Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL> writes:
> 
>     Erik> Looks like your system has an old version of modutils. You need Adrian
>     Erik> Bunk's linux-2.4 packages for running linux-2.4.* with Debian potato.
>     Erik> Add the following two lines to /etc/apt/sources.list:
> 
>     Erik> deb http://people.debian.org/~bunk/debian potato main
>     Erik> deb-src http://people.debian.org/~bunk/debian potato main
> 
>     I have just the first line of those. dpkg --list | grep modutils shows:
> 
> ii  modutils       2.4.6-2.bunk   Linux module utilities.
> 
>     Is it OK?

Yes, that's the same as I have in my system. The only difference is
that I don't use kbuild but build the kernels by hand (done that since
linux-1.0.8, hard habit to break :). Or maybe you still have some cruft
left in /etc/modutils/paths.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
