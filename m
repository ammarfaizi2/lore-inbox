Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270339AbRHHFhs>; Wed, 8 Aug 2001 01:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270341AbRHHFhj>; Wed, 8 Aug 2001 01:37:39 -0400
Received: from cardinal0.Stanford.EDU ([171.64.15.238]:19181 "EHLO
	cardinal0.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S270339AbRHHFhe>; Wed, 8 Aug 2001 01:37:34 -0400
Date: Tue, 7 Aug 2001 22:37:39 -0700 (PDT)
From: Ted Unangst <tedu@stanford.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: summary Re: encrypted swap
In-Reply-To: <fa.fk6d0vv.vgmm1i@ifi.uio.no>
Message-ID: <Pine.GSO.4.31.0108072230340.20246-100000@cardinal0.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> David Wagner wrote:
>
> >You missed some scenarios.  Suppose I run a server that uses crypto.

oh, there's lots of scenarios. :)  i am definitely in the camp that says
encrypted swap is good, though.  and that was a good one.

On Wed, 8 Aug 2001, Ben Ford wrote:

> Wiping swap on boot will achieve the same effect.

1.  takes far longer.  encrypting swap is not a substantial operation.
wiping is.  you'd have to wipe all 0's, then a 1010 pattern, then all 1's
to get decent security. (encryption is spread out over time - done
incrementally.  wiping must be done all at once.)

2.  anyone stealing a disk to get data out of it sure as hell isn't going
to boot it up and run your init scripts.



--
"People blame me because these water mains break, but I ask you,
if the water mains didn't break, would it be my responsibility to
fix them then? WOULD IT!?!"
      - M. Barry, Mayor of Washington, DC

