Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288623AbSA2MzK>; Tue, 29 Jan 2002 07:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288810AbSA2MzA>; Tue, 29 Jan 2002 07:55:00 -0500
Received: from mx2.elte.hu ([157.181.151.9]:52682 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288623AbSA2Myp>;
	Tue, 29 Jan 2002 07:54:45 -0500
Date: Tue, 29 Jan 2002 15:52:20 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Rob Landley <landley@trommello.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <E16VXQP-0000A8-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0201291544420.6701-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Daniel Phillips wrote:

> [...] Consider my patch to fix group descriptor corruption in Ext2,
> submitted half a dozen times to Linus and other maintainers over the
> course of two years, which was clearly explained, passed scrutiny on
> ext2-devel and lkml, fixed a real problem that really bit people and
> which I'd been running myself over the entire period.  Which one of
> cleanliness, concept, timing or testing did I violate?
>
> If the answer is 'none of the above', then what is wrong with this
> picture?

am i correct that you are referring to this patch?:

   http://www.uwsg.iu.edu/hypermail/linux/kernel/0011.3/0861.html

was this the first iteration of your patch? Your mail is a little more
than 1 year old. You rated the patch as: 'The fix below is kind of
gross.'. Clearly, this does not help getting patches applied.

the ext2 bh-handling code had cleanliness issues before. I had ext2
patches rejected by Linus because they kept the method of passing around
double-pointers, and i have to agree that the code was far from clean. Al
did lots of cleanups in this area, and i think he fixed this issue as
well, didnt he? So where is the problem exactly, does 2.4 still have this
bug?

in terms of 2.2 and 2.0, you should contact the respective maintainers.

	Ingo

