Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160308AbQG2MHE>; Sat, 29 Jul 2000 08:07:04 -0400
Received: by vger.rutgers.edu id <S157287AbQG2MGw>; Sat, 29 Jul 2000 08:06:52 -0400
Received: from [193.117.73.30] ([193.117.73.30]:24382 "EHLO www.bilboul.com") by vger.rutgers.edu with ESMTP id <S157289AbQG2MGj>; Sat, 29 Jul 2000 08:06:39 -0400
Newsgroups: localnet.mail.linux.kernel
Path: sweh
From: sweh@spuddy.mew.co.uk (Stephen Harris)
Subject: Re: RLIM_INFINITY inconsistency between archs
Message-ID: <FyGG0y.Mr0@spuddy.mew.co.uk>
Organization: Spud's Public Usenet Domain
X-Newsreader: TIN [version 1.2 PL2]
References: <FyFI8n.IpM@spuddy.mew.co.uk>
Date: Sat, 29 Jul 2000 10:34:10 GMT
To: unlisted-recipients: ; (no To-header on input)
Sender: owner-linux-kernel@vger.rutgers.edu

Khimenko Victor (khim@sch57.msk.ru) wrote:

: And I find it ridiculous. Yes, for FILES I agree - it's place to install
: local files for system. But for directory stubs... Where the hell I must
: put local perl packages ? I prefer /usr/local/lib/perl for architecture
: specific-ones and /usr/local/share/perl . And I (as dstribuion creator)
: even can configure perl to use this directories. But I CAN NOT (according
: to FHS) create this directories. Gosh. So now I need to GUEES where I can

This is an old question and was hashed out many times on the original
FSSTND list (yikes, back in the early 90's!).  If you are creating a general
purpose distribution, then these files are _not_ local to anything, so
/usr/local is trivially the wrong place.  If you are creating a distribution
local to your company, then feel free to use /usr/local.  If you are
automating an install for your environment, then feel free to use /usr/local.

Any distribution that uses /usr/local for general distribution is not FSSTND
(sorry, FHS) compliant.

It's very simple, really.

: Your packager should handle this. If it's not part of OS then it should be
: installed in /opt - this part of FHS looks Ok.

And this had the most arguments of all :-)  Probably 60% of all traffic
was about this :-)
-- 
                                 Stephen Harris
                 sweh@spuddy.mew.co.uk   http://www.spuddy.org/
      The truth is the truth, and opinion just opinion.  But what is what?
       My employer pays to ignore my opinions; you get to do it for free.      
  * Meeeeow ! Call  Spud the Cat on > 01708 442043 < for free Usenet access *

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
