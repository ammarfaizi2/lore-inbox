Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281911AbRKUPk5>; Wed, 21 Nov 2001 10:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281909AbRKUPks>; Wed, 21 Nov 2001 10:40:48 -0500
Received: from [195.66.192.167] ([195.66.192.167]:7693 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S281905AbRKUPkh>; Wed, 21 Nov 2001 10:40:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: bill@eb0ne.net, Bill Crawford <billc@netcomuk.co.uk>
Subject: Re: Linux-kernel-daily-digest digest, Vol 1 #171 - 281 msgs
Date: Wed, 21 Nov 2001 17:39:49 +0000
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111201202.fAKC2Md29689@lists.us.dell.com> <01112112032600.01961@nemo> <3BFBC5C5.82366455@netcomuk.co.uk>
In-Reply-To: <3BFBC5C5.82366455@netcomuk.co.uk>
MIME-Version: 1.0
Message-Id: <01112117394902.02798@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 November 2001 15:18, Bill Crawford wrote:
>  Now, ACLs I want to see widely supported on Linux, and *used* properly
> too.  They've been little used in most environments I've seen even on
> systems that do support them, which is a shame as they are a necessary
> and useful idea.  Yes, the Un*x permissions system does have some
> limitations, but let's not break *all* the existing software and OSs
> that use them, since what you're suggesting will not improve things.

Hmm. I thought proper group management can let you live with std UNIX
file permissions model... NT ACLs are horrendously complex.
"Make it as simple as possible, but not simpler"

> > versions of it). It's too late. I've made patch for chmod which adds new
> > +R flag to that effect.

>  Why is that needed anyway?  By default directories get execute bit set
> when they're created, at least in my environment; if you're extending
> permissions you can use "go=u" or "o=g" to broaden the permissions, as
> I would expect the existing perms to be correct on files vs directories
> in most cases.

It is legitimate to do that. Do I really have to explain?

I have a script which is designed to sweep entire tree starting from /
and do some sanity checks. For example, it Opens Source:

chmod -R -c a+R /usr/src

8-)

--
vda
