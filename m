Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264248AbTDKF21 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 01:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264254AbTDKF20 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 01:28:26 -0400
Received: from [195.95.38.160] ([195.95.38.160]:48376 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S264248AbTDKF2Z convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 01:28:25 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Jon Portnoy <portnoy@tellink.net>,
       "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: kernel support for non-english user messages
Date: Fri, 11 Apr 2003 07:39:35 +0200
User-Agent: KMail/1.5.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devilkin-lkml@blindguardian.org
References: <3E93A958.80107@si.rr.com> <Pine.LNX.4.53.0304101638010.4978@chaos> <Pine.LNX.4.53.0304101903280.19136@cerberus.oppresses.us>
In-Reply-To: <Pine.LNX.4.53.0304101903280.19136@cerberus.oppresses.us>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304110739.41947.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 11 April 2003 01:05, Jon Portnoy wrote:
> A whole lot of users use dmesg output to figure out if their kernel is
> detecting a piece of hardware. That's a very useful thing to have handy
> and definitely not something that should be yanked out for the sake of
> making it look pretty for people who don't know what they're doing with
> their computer.

True. 

Why not turn it into a kernel flag that you can set at bootup through LILO or 
some other obscure boot manager? Then you could boot linux like this:

linux dmesg=verbose

and

linux dmesg=quiet

with any of the two being the default setting. This way you can have the cake 
and eat it too: the verbose setting for those that want it, and the quiet 
setting for the users that don't want to get scared sh*tless everytime their 
system boots. I know I got scared first time I booted a Linux box :P

Jan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+llUapuyeqyCEh60RAoQiAJ482mlR4GYiagB3r05dDRaYtJfWJACfSow4
qO0z3Q68S5TRoUqENlB/Asc=
=tMBA
-----END PGP SIGNATURE-----

