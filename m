Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293186AbSBWSWe>; Sat, 23 Feb 2002 13:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293173AbSBWSWQ>; Sat, 23 Feb 2002 13:22:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58377 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293174AbSBWSWL>; Sat, 23 Feb 2002 13:22:11 -0500
Date: Sat, 23 Feb 2002 10:20:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Rusty Russell <rusty@rustcorp.com.au>,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Lightweight userspace semaphores...
In-Reply-To: <Pine.LNX.4.33.0202231551300.4173-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0202231017310.9185-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Feb 2002, Ingo Molnar wrote:
>
> On Sat, 23 Feb 2002, Rusty Russell wrote:
>
> > 1) Interface is: open /dev/usem, pread, pwrite.
>
> i like the patch, but the interface is ugly IMO. Why not new syscalls?

I agree - I dislike magic device files a whole lot more than just abotu
every alternative.

Also, one thing possibly worth looking into is to just put the actual
semaphore contents into a regular file backed setup.

		Linus

