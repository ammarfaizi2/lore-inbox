Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261328AbSIYXsh>; Wed, 25 Sep 2002 19:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261487AbSIYXsh>; Wed, 25 Sep 2002 19:48:37 -0400
Received: from mta03ps.bigpond.com ([144.135.25.135]:19952 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S261328AbSIYXsf>; Wed, 25 Sep 2002 19:48:35 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Stian Jordet <liste@jordet.nu>, linux-kernel@vger.kernel.org
Subject: Re: Mouse/Keyboard problems with 2.5.38
Date: Thu, 26 Sep 2002 09:47:02 +1000
User-Agent: KMail/1.4.5
References: <1032996672.11642.6.camel@chevrolet>
In-Reply-To: <1032996672.11642.6.camel@chevrolet>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209260947.02597.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, 26 Sep 2002 09:31, Stian Jordet wrote:
> But now I decided I should try again. I got 2.5.38 booted after some
> initial trouble. But, I have a couple of weird problems. First, the
> mouse. I have a Logitech Cordless Optical mouse. With kernel 2.4.x I use
> MouseManPlusPS/2 as the XFree mouse-driver. Then I can use the wheel and
> the fourth button just as expected. But with kernel 2.5.38 neither the
> wheel or the fourth button works. I change protocol to IMPS/2 in XFree,
> and everything works like expected, but the fourth button works just
> like pussing the wheel (third button). This is excactly the same
> behavior as with 2.4.20-pre7 (that's why I use MouseManPlusPS/2). Anyone
> have a clue why this doesn't work with kernel 2.5.38?
Input support was merged, that fundamentally changes the way input handling 
works. The new input layer mousedev handler tries to guess which mode you 
want. Maybe you want the explorer PS/2 protocol? Or wait for X to get a nice 
event input driver.

> Second problem, if I press SHIFT+PAGEUP, my computer freezes. It spits
> out this message: "input: AT Set 2 keyboard on isa0060/serio0, and then
> it's dead. I have a Logitech cordless keyboard.
I'm using a logitech cordless too. However mine is on USB, and I guess you are 
using some PS/2 connector? USB is much better tested, so there may be some 
bugs.

Brad

- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Aust. Tickets booked.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9kkr2W6pHgIdAuOMRAhibAJ9ZJJoCQCvOExxTxQFYZvfN91mp3QCeJNDC
WT/qGY0Dj7XogoVMJZ4jywo=
=YG6j
-----END PGP SIGNATURE-----

