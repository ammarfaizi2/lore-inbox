Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281906AbRKUPTF>; Wed, 21 Nov 2001 10:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281905AbRKUPSy>; Wed, 21 Nov 2001 10:18:54 -0500
Received: from gatekeeper.corp.netcom.net.uk ([194.42.224.25]:1968 "EHLO
	gatekeeper") by vger.kernel.org with ESMTP id <S281904AbRKUPSv>;
	Wed, 21 Nov 2001 10:18:51 -0500
Message-ID: <3BFBC5C5.82366455@netcomuk.co.uk>
Date: Wed, 21 Nov 2001 15:18:29 +0000
From: Bill Crawford <billc@netcomuk.co.uk>
Reply-To: bill@eb0ne.net
Organization: Netcom Internet Ltd
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-0.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux-kernel-daily-digest digest, Vol 1 #171 - 281 msgs
In-Reply-To: <200111201202.fAKC2Md29689@lists.us.dell.com> <3BFA8AE2.2B5FA0@netcomuk.co.uk> <01112112032600.01961@nemo>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda wrote:

> >  Perhaps we should not distinguish between read and execute on programs
> > either?  After all, they're not much different, are they?

 This was intended to be sarcastic :o)

> Yes, we can. In fact, NT lives with it with no problem. It is very common
> in NT to have rx on all readable files regardless of their 'executability'.
> If someone have 'r' perms, he can make a copy of a file, flag it with x and
> execute.

 In theory one can do just that on Un*x systems too.  That's why setid
bits can't be set by just anybody.

 What if the program is setuid and executable by a group but not other?
We do this with "su" on servers.

 Now, ACLs I want to see widely supported on Linux, and *used* properly
too.  They've been little used in most environments I've seen even on
systems that do support them, which is a shame as they are a necessary
and useful idea.  Yes, the Un*x permissions system does have some
limitations, but let's not break *all* the existing software and OSs
that use them, since what you're suggesting will not improve things.

> versions of it). It's too late. I've made patch for chmod which adds new +R
> flag to that effect.

 Why is that needed anyway?  By default directories get execute bit set
when they're created, at least in my environment; if you're extending
permissions you can use "go=u" or "o=g" to broaden the permissions, as
I would expect the existing perms to be correct on files vs directories
in most cases.

> --
> vda

-- 
/* Bill Crawford, Unix Systems Developer, Ebone (formerly GTS Netcom) */
#include <stddiscl>
const char *addresses[] = {
    "bill@syseng.netcom.net.uk", "Bill.Crawford@ebone.com",     // work
    "billc@netcomuk.co.uk", "bill@eb0ne.net"                    // home
};
