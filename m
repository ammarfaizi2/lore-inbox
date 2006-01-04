Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751621AbWADVNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWADVNc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWADVNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:13:32 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:27605 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750711AbWADVNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:13:31 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Mark Lord <lkml@rtr.ca>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14.5 to 2.6.15 patch
Date: Thu, 05 Jan 2006 08:13:27 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <g5eor1tp6jr24u0gej4a2puc954kq59ug5@4ax.com>
References: <200601041710.37648.nick@linicks.net> <200601041728.52081.nick@linicks.net> <9a8748490601040940peb15b75n454e02a622f795e1@mail.gmail.com> <200601041745.39180.nick@linicks.net> <9a8748490601040950q2b2691f5l7577b52417b4c50b@mail.gmail.com> <Pine.LNX.4.58.0601040950530.19134@shark.he.net> <9a8748490601040956qa427366n3daea86e531763e8@mail.gmail.com> <43BC0F0A.2060605@rtr.ca> <9a8748490601041013j61eb992eucd5abe9dcaf8d2ce@mail.gmail.com>
In-Reply-To: <9a8748490601041013j61eb992eucd5abe9dcaf8d2ce@mail.gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006 19:13:08 +0100, Jesper Juhl <jesper.juhl@gmail.com> wrote:

>On 1/4/06, Mark Lord <lkml@rtr.ca> wrote:
>> Jesper Juhl wrote:
>> >
>> >>but the incremental patches do appear to be in
>> >>  http://www.kernel.org/pub/linux/kernel/v2.6/incr/
>> ..
>> >
>> > Hmm, yes, you are right. I was not aware of those. When did those
>> > start to apear?
>> > Guess I need to update applying-patches.txt if those are automated...
>>
>> That's how Greg posts them to LKML also -- as incremental patches.
>>
>Yes, I know that's what he posts them on LKML, I just never knew that
>they got archived on kernel.org in incr. form as well.  Now I know :-)

Easy to revert 2.6.14.5 to 2.6.14 then patch to 2.6.15 if you follow 
the stable series.  Still saves ~30MB downloading source.

Because I'm also compiling the -rc? and -mm? I keep 2.6.14 tree and use 
hardlink trees, when 2.6.15 came out I patched the 2.6.14 to 2.6.15 
and deleted the development trees -- works for me ;)

And no, I'll not automate this, it's enough dealing with finger trouble 
let alone scripts doing things behind my back!  I have vim trained to 
break hardlink files on write, I don't get myself in trouble so much.

Grant.
