Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291274AbSBMCat>; Tue, 12 Feb 2002 21:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291311AbSBMCai>; Tue, 12 Feb 2002 21:30:38 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:1154 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S291274AbSBMCa2>; Tue, 12 Feb 2002 21:30:28 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is a livelock? (was: [patch] sys_sync livelock fix)
In-Reply-To: <3C69A18A.501BAD42@zip.com.au> <3C69A18A.501BAD42@zip.com.au>
	<87y9hyw4b6.fsf@tigram.bogus.local> <3C69C7E9.E01C3532@zip.com.au>
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: Wed, 13 Feb 2002 03:30:01 +0100
Message-ID: <87pu3aw1ue.fsf@tigram.bogus.local>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> http://www.huis.hiroshima-u.ac.jp/jargon/LexiconEntries/Livelock.html
>
> livelock
>
> /li:v'lok/ n. A situation in which some critical stage of a task is
> unable to finish because its clients perpetually create more work
> for it to do after they have been serviced but before it can clear its
> queue. Differs from {deadlock} in that the process is not blocked or
> waiting for anything, but has a virtually infinite amount of work to
> do and can never catch up. 

I still don't get it :-(. When there is more work, this more work
needs to be done. So, how could livelock be considered a bug? It's
just overload. Or is this about the work, which must be done _after_
the queue is empty?

Regards, Olaf.
