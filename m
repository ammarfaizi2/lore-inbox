Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316627AbSEVSDz>; Wed, 22 May 2002 14:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316628AbSEVSDy>; Wed, 22 May 2002 14:03:54 -0400
Received: from web12307.mail.yahoo.com ([216.136.173.105]:24076 "HELO
	web12307.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316627AbSEVSDv>; Wed, 22 May 2002 14:03:51 -0400
Message-ID: <20020522180350.28170.qmail@web12307.mail.yahoo.com>
Date: Wed, 22 May 2002 11:03:50 -0700 (PDT)
From: Myrddin Ambrosius <imipak@yahoo.com>
Subject: Linux crypto?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that Motorola has published a set of tech
docs for their S1-range of crypto co-processors, which
look pretty comprehensive. (The 190 looks to be a very
nice chip, which -as best as I can tell- just plugs
straight onto a PCI bus.) Other co-pro manufacturers
(such as HIFN) seem to also have humungous tech
manuals for their crypto chips.

Is anyone working on drivers for these beasties?

Alongside that, I also noticed that many manufacturers
(again, Motorola and HIFN seem to top the list)
working on network accelerator chips - some h/w
L2/L3/L4 queueing/filtering, rudimentary packet
mangling, etc. Linux already has most of the
interesting stuff from the chips I've looked at, and
in most places is way more advanced in what it can do/
Given the ipfilter design, would there be any way to
use those chips as an additional networking layer?
(And, just as importantly, would there be any point?)

Secondly, I've taken a look at the "International
Kernel Patch" for Linux. I have finally found a
(fairly) mainstream kernel patch that is updated less
frequently than my own FOLK patch! Also, nobody seems
to use it. Packages that use crypto seem to steer
towards openssl, rsa-ref, mcrypt/mhash/gcrypt, gnutls,
and/or or private implementations. Even FreeS/WAN and
USAGI take no advantage of anything in the IKP.

Ignoring, for a second, the US export laws (which are
no longer an issue, anyway), is there some fundamental
reason why the IKP seems to be ignored? If there is,
then does anyone know of any re-design/re-write
effort?


__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com
