Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSGMSli>; Sat, 13 Jul 2002 14:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSGMSlh>; Sat, 13 Jul 2002 14:41:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57609 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315279AbSGMSlh>; Sat, 13 Jul 2002 14:41:37 -0400
Date: Sat, 13 Jul 2002 11:46:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Muli Ben-Yehuda <mulix@actcom.co.il>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: compile the kernel with -Werror
In-Reply-To: <1026570243.9958.81.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207131143540.16670-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 13 Jul 2002, Alan Cox wrote:
>
> May I suggest the user learns to use the command line properly. Adding
> -Werror doesn't help because gcc emits far too many bogus warnings for
> that.

Especially _some_ versions of gcc.

We've tried this before, and there are versions of gcc that have some
warnings on by default that simply aren't acceptable and cannot be avoided
sanely (I think at least some snapshots had the sign warnings on, for
example, which causes some really silly warnings where the warnings are
less odious than the changes required to get rid of them).

That said, I don't think -Werror is really wrong. It might make it less
likely to have new drivers introducing unnecessary warnings..

		Linus

