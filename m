Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281970AbRKUSNr>; Wed, 21 Nov 2001 13:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281942AbRKUSN1>; Wed, 21 Nov 2001 13:13:27 -0500
Received: from gatekeeper.corp.netcom.net.uk ([194.42.224.25]:45498 "EHLO
	gatekeeper") by vger.kernel.org with ESMTP id <S281953AbRKUSNX>;
	Wed, 21 Nov 2001 13:13:23 -0500
Message-ID: <3BFBEEAD.67DF8932@netcomuk.co.uk>
Date: Wed, 21 Nov 2001 18:13:01 +0000
From: Bill Crawford <billc@netcomuk.co.uk>
Reply-To: bill@eb0ne.net
Organization: Netcom Internet Ltd
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-0.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
CC: bill@eb0ne.net, linux-kernel@vger.kernel.org
Subject: Re: Linux-kernel-daily-digest digest, Vol 1 #171 - 281 msgs
In-Reply-To: <200111201202.fAKC2Md29689@lists.us.dell.com> <01112112032600.01961@nemo> <3BFBC5C5.82366455@netcomuk.co.uk> <01112117394902.02798@nemo>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda wrote:

> Hmm. I thought proper group management can let you live with std UNIX
> file permissions model... NT ACLs are horrendously complex.
> "Make it as simple as possible, but not simpler"

 You can, but there are situations where you end up with a combinatorial
explosion of groups to accommodate a matrix of possible permissions on
things.  And there is another significantly limiting factor which is the
restriction on the number of groups a process can belong to (currently
32 I believe).

 I think ACLs are a good solution to the problem, and indeed are what
*should* have been done originally ... however I suspect that would have
added a significant overhead to the original UNIX, and one of the great
benefits at the time was that UNIX was designed to run on pretty low-end
hardware.  VMS was a heavyweight beast on VAXen, did it ever run on PDP
machines?  There was a complex system :o)

 I'm thinking of Solaris' ACLs rather than NT, I don't know much about
the latter so I can't really comment on them.

> It is legitimate to do that. Do I really have to explain?

 No, I know what you're trying to do.  I have done it myself many times.
Why some sources come packed so they're only readable by root is beyond
me :o)

> I have a script which is designed to sweep entire tree starting from /
> and do some sanity checks. For example, it Opens Source:
> 
> chmod -R -c a+R /usr/src
> 
> 8-)

 OK, point conceded, although I can live with two passes for that sort
of thing.  Yours is a neat solution in fact.

> --
> vda

-- 
/* Bill Crawford, Unix Systems Developer, Ebone (formerly GTS Netcom) */
#include <stddiscl>
const char *addresses[] = {
    "bill@syseng.netcom.net.uk", "Bill.Crawford@ebone.com",     // work
    "billc@netcomuk.co.uk", "bill@eb0ne.net"                    // home
};
