Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267698AbUHEN54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267698AbUHEN54 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267695AbUHENyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:54:55 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:10991 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267699AbUHENyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:54:01 -0400
Message-ID: <d577e56904080506542334347c@mail.gmail.com>
Date: Thu, 5 Aug 2004 09:54:01 -0400
From: Patrick McFarland <diablod3@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.8-rc3
Cc: arjanv@redhat.com, "J. Bruce Fields" <bfields@fieldses.org>,
       James Morris <jmorris@redhat.com>,
       Jari Ruusu <jariruusu@users.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>,
       Fruhwirth Clemens <clemens@endorphin.org>
In-Reply-To: <Pine.LNX.4.58.0408041130530.24588@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4110FB0E.230CE613@users.sourceforge.net> 
 <Xine.LNX.4.44.0408041156310.9291-100000@dhcp83-76.boston.redhat.com> 
 <20040804161046.GD19282@fieldses.org> <1091636850.2792.19.camel@laptop.fenrus.com>
 <d577e56904080411192f17e508@mail.gmail.com> <Pine.LNX.4.58.0408041130530.24588@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004 11:45:12 -0700 (PDT), Linus Torvalds
<torvalds@osdl.org> wrote:
> Side note: Jari Ruusu has himself been distributing the code he now
> objects to as part of his own linux kernel loop-aes patches. From the
> loop-aes README:
> 
>         Copyright 2001,2002,2003,2004 by Jari Ruusu.
>         Redistribution of this file is permitted under the GNU Public License.
> 
> But the original x86 assembler code that is part of that loop-aes patch
> was copyright Dr Brian Gladman, and was NOT originally under the GPL, so
> it was Jari Ruusu who originally did something very suspect from a
> copyright angle. Now he claims he never wanted to GPL it, but the fact is,
> he's been distributing kernel patches with the code for a long time, and
> claiming it is GPL'd.
> 
> So then David and James wanted to include it into the kernel as part of
> the standard encryption layer, and I said no, since I felt the copyright
> wasn't clear. So James asked Dr Gladman for permission to dual-license
> under the GPL, and got it. So I was happy.
> 
> Now Jari Ruusu comes along and starts complaining about things.

So, I'm confused. David, James, and Brian all have GPL code, and Jari
has distributed his code with other GPL code (1) and labled his own
code as GPL (2) even though hes complaining about it (3) being in the
kernel without his permission, right?

1) Doesn't this make his code GPL as well?
2) If #1 doesn't, doesn't this?
3) If #1 or #2 make his code GPL, then he isn't allowed to revoke our
right to use GPL code written by him, right?

If I've missed something, please tell me. Im also confused why anyone
_wouldn't_ want their code in the kernel; I consider it a great honor
to have a patch accepted with my code in it, etc.

-- 
Patrick "Diablo-D3" McFarland || diablod3@gmail.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, we'd 
all be running around in darkened rooms, munching magic pills and listening to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989
