Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265922AbSKBKjd>; Sat, 2 Nov 2002 05:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265926AbSKBKjd>; Sat, 2 Nov 2002 05:39:33 -0500
Received: from mta02ps.bigpond.com ([144.135.25.134]:48096 "EHLO
	mta02ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S265922AbSKBKjc>; Sat, 2 Nov 2002 05:39:32 -0500
From: Brad Hards <bhards@bigpond.net.au>
To: "Matt D. Robinson" <yakker@aparity.com>
Subject: Re: What's left over.
Date: Sat, 2 Nov 2002 21:36:50 +1100
User-Agent: KMail/1.4.5
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44.0210311737020.23393-100000@nakedeye.aparity.com>
In-Reply-To: <Pine.LNX.4.44.0210311737020.23393-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200211022136.51039.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 1 Nov 2002 13:01, Matt D. Robinson wrote:
<snip>
> Uh ... have you read the patches?  Do you see how few the
> changes are to non-dump code?  Do you know that most of those
> changes only get triggered in a crash situation anyway?
I applied the patches, and reported some issues.
http://marc.theaimsgroup.com/?l=linux-kernel&m=103520434201014&w=2
I see no signs that any of them have been addressed, although I haven't tried 
a really recent set.

> Breakage occurs when people change code areas that are used
> all the time, like VM, network, block layer, etc.
Actually, this is the area that Linux is best at. If you break it, some poor 
sod will hit the problem, and you'll know really soon.

> Look at the patches and tell me where we are causing overhead
> and and seriously potential breakage.  If you find problems,
> then tell us, don't just comment on breakage scenarios.

I'm a fairly typical user - I just have a couple of desktop machines and a 
server/firewall. 

I don't have 700 nodes in a cluster, and when my machines break, its normally 
something I did. Sometimes the desktop locks up (say every second month, 
unless I'm dicking with the kernel), but I reboot and everything is happy.

LKCD doesn't really seem to do anything for me - it wouldn't really worry me 
if it went in (since I don't have to maintain it - it isn't near any of my 
code), but I'd really prefer that having the _CONFIG option set to N didn't 
make the kernel any bigger, or change any code paths.

Is this unreasonable?

Brad

BTW: I admit that I'd be pretty pissed if Linus said that my code was 
"stupid", but life isn't reasonable or fair. Take a few days off LKCD, go for 
a few walks, and worry about how to get it integrated after that.


- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9w6rCW6pHgIdAuOMRAlI5AJ48ELVdExIeCr5C5HtDpU5+1ZnuBQCdEji0
t4q2NjZQVGEumrz6b+CqEEs=
=xtYY
-----END PGP SIGNATURE-----

