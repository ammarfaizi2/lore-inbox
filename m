Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261729AbSJMWAA>; Sun, 13 Oct 2002 18:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbSJMWAA>; Sun, 13 Oct 2002 18:00:00 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:23728 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261729AbSJMV77>; Sun, 13 Oct 2002 17:59:59 -0400
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] 2.5.42: remove capable(CAP_SYS_RAWIO) check from
 open_kmem
References: <3DA985E6.6090302@colorfullife.com>
	<87adliuyp6.fsf@goat.bogus.local> <3DA99A8B.5050102@colorfullife.com>
	<873crauw1m.fsf@goat.bogus.local> <3DA9A796.4070600@colorfullife.com>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Mon, 14 Oct 2002 00:05:40 +0200
Message-ID: <87y992805n.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:

> Olaf Dietsche wrote:
>> Now, I have to run this process as root, regardless of filesystem
>> permissions. So, if I trust this particular process with full
>> privileges now, there's no problem in reducing its power a little bit.
>>
> What about writing a small wrapper application that drops all
> priveleges except CAP_RAWIO, switches to user to the user you want,
> then execs the target application that needs to access /dev/kmem?

I just tried this, but I didn't succeed. :-(

> Or store the capabilities in the filesystem, but I don't know which
> filesystem supports that.

There's none so far.

Regards, Olaf.
