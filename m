Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbVJDSav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbVJDSav (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 14:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbVJDSav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 14:30:51 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:55786 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S964906AbVJDSau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 14:30:50 -0400
Message-ID: <4342C9F1.2000005@comcast.net>
Date: Tue, 04 Oct 2005 14:29:05 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050912)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: The price of SELinux (CPU)
References: <434204F8.2030209@comcast.net> <200510041539.j94FdJmO028772@turing-police.cc.vt.edu>
In-Reply-To: <200510041539.j94FdJmO028772@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Valdis.Kletnieks@vt.edu wrote:
> On Tue, 04 Oct 2005 00:28:40 EDT, John Richard Moser said:
> 
> 
>>At any rate, my personal end goal is a secure high-performance operating
>>system, as user friendly as 
> 
> 
> Step 0: Sooner or later, "secure" and "user friendly" *will* come into conflict.

It's a lot later than you think.  A home desktop OS isn't a server OS;
and a server OS isn't a home desktop OS.  That being said, something
doesn't have to be as wide-open as the goatse guy's ass to be suitable
for every tom dick and moron.

> At that point, you have to make a choice. Note that in many cases, we *made* the
> choice years or even decades ago, and we've gotten used to the choices made.
> For instance, you'd certainly get better performance and user friendliness if
> you just stubbed out permission() in fs/namei.c and capable(), and just had them
> return "let the guy do it".  But somehow, I don't think anybody would find that
> very palatable.
> 

Would you now?  The performance gain would be negligible, even if it
were there; the user friendly factor would be pretty nil.  I mean the
user now can administrate his system without entering a password before
hitting the configuration center -- which he does every several weeks if
that.

Aside from this, viruses and spyware and worms can now run rampant and
do what they want to his system, and other users' idiotic actions on a
multi-user system affect him.  This is more user friendly?  No, I think
it's going in the opposite direction. . . .

The choice was made at Windows with "Let the desktop user run as
administrator;" in Linux it's typically made at "We've designed an OS
that runs very, very well with your account limited."  They're both
roughly equivalent in terms of user friendly (I think linux with Gnome
or KDE is actually easier, so does my mom).

> Similarly, the stuff that comes out of Redmond, in general, has security issues
> precisely because they chose "user friendly" when they got to Step 0.  Being
> able to put Javascript and/or executable binaries in e-mail for automatic
> execution is certainly user-friendly - but it's not secure.
> 

There's "user friendly," and then there's just ass.  Switzerland gives
each and every child a rifle and trains them to use it at age 12 IIRC;
this would be "user friendly."  Now, if you want to be just ass, hand
every 4 year old a gun with live ammunition and wait for them to put a
bullet in someone's brain and learn on their own that you shouldn't
shoot people unless you really mean it.

Open source programs achieve "user friendly" in a responsible manner.
Firefox doesn't have a local machine zone with javascript able to write
to files directly; thunderbird doesn't auto-run certain scripts; the
file browser isn't integrated into the web browser in anything but KDE
(which I personally dislike for other reasons).

> In any case, the overhead isn't 7%.  If anything, it's probably closer to 0.7%,
> and dropping with each kernel release as the code gets tuned and optimized even
> more.  And beware the impact of micro-optimizations and macro-performance - there
> was recently a code change to reduce the number and size of avtab entries.  That
> slowed down the actual code path slightly, but overall was actually a performance
> win, especially on smaller memory-constrained machines, due to the drastic drop
> in overall slab consumption.

Nice.  Some IBM guys said they're gonna rebench soon so I'm looking
forward to that, but this is reassuring.

> 
> And remember - the first time that a security system prevents (for example) an
> exploit against an Apache bug from being used to take over a system, it's paid
> for itself.  When the FBI faxes you that "Hold Evidence" order, it means you may
> not be seeing that server again for weeks, if ever.....

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDQsnwhDd4aOud5P8RAmmWAJ9JJquzIPzjVlm5w0OxrBAwOJP6gwCeOHYv
sVpFxYCDZvKbhUOq86dqog4=
=i9Fd
-----END PGP SIGNATURE-----
