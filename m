Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbVJDFAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbVJDFAo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 01:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVJDFAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 01:00:44 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:56996 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751173AbVJDFAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 01:00:43 -0400
Message-ID: <43420C1B.3020607@comcast.net>
Date: Tue, 04 Oct 2005 00:59:07 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050912)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan C Marinescu <dan_c_marinescu@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: The price of SELinux (CPU)
References: <20051004043855.31468.qmail@web35508.mail.mud.yahoo.com>
In-Reply-To: <20051004043855.31468.qmail@web35508.mail.mud.yahoo.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm not an abortionist; if I hear something has an ugly side, I try to
find out if it can be fixed, and if the trade-off is worth getting rid
of it.  SELinux and LSM are quite useful you know; the overhead is
probably not even that significant on the desktop to gamers (although if
you TELL them about it they'll piss themselves), from a practical
viewpoint considering their excessive hardware.

Dan C Marinescu wrote:
> try selinux=0, _if u feel that way :-)
> 
> about big o:
> 
> http://www.maththinking.com/boat/compsciBooksIndex.html
> 
>    daniel
> 
> 
> 
> --- John Richard Moser <nigelenki@comcast.net> wrote:
> 
> 
> I've heard that SELinux has produced benchmarks such
> as 7% increased CPU
> load.  Is this true and current?  Is it dependent on
> policy?  What is
> the policy lookup complexity ( O(1), O(n),
> O(nlogn)...)?  Are there
> other places where a bottleneck may exist aside from
> gruffing with the
> policy?  Isn't the policy actually in xattrs so it's
> O(1)?  Where else
> would an overhead that big come from aside from a
> lookup in a table?
> 
> ....
> 
> Why is the sky blue?  Why do you have a mustach? 
> Why doesn't mommy have
> one?  Does she shave it?
> 
> At any rate, my personal end goal is a secure
> high-performance operating
> system, as user friendly as Ubuntu, Mandriva, or
> Win----.  To this end,
> I'm (still; a lot of you have seen me before)
> evaluating the performance
> hit of various user and kernel security enhancements
> like PaX,
> ProPolice, various OpenWall/GrSecurity niceness that
> needs to be divided
> out, and of course LSM/SELinux.  Also wondering
> about that PHKMalloc
> thing on openbsd; is it really all that, is it junk,
> how's it compare to
> the recent ptmalloc work, and can it run on Linux
> for direct benching .
> . . but that's off topic.
> 
> --
> All content of all messages exchanged herein are
> left in the
> Public Domain, unless otherwise explicitly stated.
> 
>     Creative brains are a valuable, limited
> resource. They shouldn't be
>     wasted on re-inventing the wheel when there are
> so many fascinating
>     new problems waiting out there.
>                                                  --
> Eric Steven Raymond
- -
To unsubscribe from this list: send the line
"unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

> __________________________________ 
> Yahoo! Mail - PC Magazine Editors' Choice 2005 
> http://mail.yahoo.com


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

iD8DBQFDQgwahDd4aOud5P8RArHEAJ9GFTpKPX3BbAR9vF/UCxeqbXO8DQCgi3sC
R8bKVy1wxP2SiGJyc0MB4Xw=
=vvMx
-----END PGP SIGNATURE-----
