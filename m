Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267179AbTCASdu>; Sat, 1 Mar 2003 13:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268969AbTCASdt>; Sat, 1 Mar 2003 13:33:49 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:26807 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S267179AbTCASds>; Sat, 1 Mar 2003 13:33:48 -0500
Message-ID: <3E6101DE.5060301@kegel.com>
Date: Sat, 01 Mar 2003 10:54:22 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Matthias Schniedermeyer <ms@citd.de>
CC: Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mike@aiinc.ca
Subject: Re: [PATCH] kernel source spellchecker
References: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de>
In-Reply-To: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> I've no spelling knowledge, so the list of spellcorrections must be made
> by someone else. But i can volunteer the perl-snippet to correct the
> files. :-)

Smashing!  However, it should probably avoid correcting spellings
in anything but C comments.
Perhaps my C comment parser should be converted to perl and
incorporated into spell-fix.pl, and used to divide the source
file into two streams (comment and noncomment); the comment
stream would be spell-fixed and merged back with the noncomment
stream to create the output.

And thanks to Shaheed for converting my list of misspellings to a correction list!

I suggest we remove the entries
  broken=borken
  brain-damaged=dain-bramaged,dain bramaged
as we're not trying to remove humor from the comments.

Also, the words 'controllen' and 'callin',  are not typos, so
  calling=callin
should be removed, and
  controller=controler,controllen
should be just
  controller=controler

The above examples make me think the list of corrections will have
to be very carefully vetted before we turn this thing loose.
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

