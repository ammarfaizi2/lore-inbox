Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129146AbRBZVZf>; Mon, 26 Feb 2001 16:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129155AbRBZVZ0>; Mon, 26 Feb 2001 16:25:26 -0500
Received: from smtp1.xs4all.nl ([194.109.127.131]:33035 "EHLO smtp1.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129146AbRBZVZG>;
	Mon, 26 Feb 2001 16:25:06 -0500
Date: Mon, 26 Feb 2001 21:22:35 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: apic patches (with MIS counter)
Message-ID: <20010226212235.B24978@grobbebol.xs4all.nl>
In-Reply-To: <20010226111328.A24978@grobbebol.xs4all.nl> <Pine.GSO.3.96.1010226122619.9420C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.3.96.1010226122619.9420C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Feb 26, 2001 at 01:14:11PM +0100
X-OS: Linux grobbebol 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2001 at 01:14:11PM +0100, Maciej W. Rozycki wrote:
>  It is already present in 2.4.2-ac3.


Yep, I just noticed it. there was a backlog from here to tokyo.

>  There is a small performance impact at every interrupt -- the code that
> checks for mismatches incurs it.  It's just a few CPU instructions, thus
> it should not be noticeable.


well I saw a lot of collisions on the hub and a slow speed (approx
150kbytes sec) but I don't think collisions & patch is the cause
:-)

> > if you like, I can start banging the machine on it's head now.
> 
>  Please do.  I believe the code is safe to be included in 2.4.3, but if
> any problem is going to pop up, it'd better do it before than after
> applying to the mainstream. 

ok, it's box killing time. I just installed a new kernel with the ptches
and some additions and will reboot after I tried to kill the system.
will report here.

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
