Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281012AbRKGVUe>; Wed, 7 Nov 2001 16:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280990AbRKGVSu>; Wed, 7 Nov 2001 16:18:50 -0500
Received: from freeside.toyota.com ([63.87.74.7]:34579 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S281006AbRKGVSH>;
	Wed, 7 Nov 2001 16:18:07 -0500
Message-ID: <3BE9A506.82D64AE4@lexus.com>
Date: Wed, 07 Nov 2001 13:17:58 -0800
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: disaster with 2.4.14+preempt
In-Reply-To: <3BE8B460.A23E1A67@pobox.com> <1005109646.884.0.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

> So I compiled 2.4.14+preempt, this time using ext2 like you.  I also
> enabled highmem and SMP, although I don't need those.  Again I ran
> multiple dbench runs, went into X, and here I am ... the kernel is
> solid.

OK I have replaced enough of the libs so that
rpm works again, and was able to do a verify
to get the rest of the pieces in order.

> What was the last kernel you had no problems with when used with
> preempt?

I was able to recover some stuff from old
backups, including the kernels I last used
under RH 7.1 -

I see vmlinuz-2.4.12-ac6, and vmlinuz-2.4.13
Both have preempt patches, and highmen
& smp support.

I know they were stable under the test.

I am pounding the old 2.4.13 kernel now
(filesystems mounted as ext2) with dbench
16, 32, 64, and 128 and it is holding up fine.

I will compile 2.4.14 without the preempt
patch and repeat -

Finally, I will repeat the 2.4.14+preempt
test, and I predict the box  will lock hard
a few seconds after typing "dbench 16"

Is there anything in particular you would
like me to try?

cu

jjs

