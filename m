Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267311AbSLRSSA>; Wed, 18 Dec 2002 13:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267312AbSLRSSA>; Wed, 18 Dec 2002 13:18:00 -0500
Received: from otter.mbay.net ([206.55.237.2]:23557 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S267311AbSLRSR7> convert rfc822-to-8bit;
	Wed, 18 Dec 2002 13:17:59 -0500
From: John Alvord <jalvo@mbay.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@redhat.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: Freezing.. (was Re: Intel P6 vs P7 system call performance)
Date: Wed, 18 Dec 2002 10:25:39 -0800
Message-ID: <m8f10v0mecjj714q67jrup4u8vsp3l3t0t@4ax.com>
References: <20021218164119.GC27695@suse.de> <Pine.LNX.4.44.0212180844550.29852-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212180844550.29852-100000@home.transmeta.com>
X-Mailer: Forte Agent 1.92/32.570
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2002 08:49:37 -0800 (PST), Linus Torvalds
<torvalds@transmeta.com> wrote:

>
>
>On Wed, 18 Dec 2002, Dave Jones wrote:
>> On Wed, Dec 18, 2002 at 10:40:24AM -0300, Horst von Brand wrote:
>>  > [Extremely interesting new syscall mechanism tread elided]
>>  >
>>  > What happened to "feature freeze"?
>>
>> *bites lip* it's fairly low impact *duck*.
>
>However, it's a fair question.
>
>I've been wondering how to formalize patch acceptance at code freeze, but
>it might be a good idea to start talking about some way to maybe put
>brakes on patches earlier, ie some kind of "required approval process".
>
>I think the system call thing is very localized and thus not a big issue,
>but in general we do need to have something in place.
>
>I just don't know what that "something" should be. Any ideas? I thought
>about the code freeze require buy-in from three of four people (me, Alan,
>Dave and Andrew come to mind) for a patch to go in, but that's probably
>too draconian for now. Or is it (maybe start with "needs approval by two"
>and switch it to three when going into code freeze)?
>
>			Linus

I think there should be a distinction between changes which make an
API change/new function/user interface change, versus bug fixes,
adapting to new APIs, documentation, etc.

john alvord
