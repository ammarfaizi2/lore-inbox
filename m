Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269856AbUJGXHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269856AbUJGXHr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269916AbUJGXHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:07:09 -0400
Received: from findaloan.ca ([66.11.177.6]:38624 "EHLO findaloan.ca")
	by vger.kernel.org with ESMTP id S268232AbUJGXE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:04:29 -0400
Date: Thu, 7 Oct 2004 19:00:19 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: "David S. Miller" <davem@davemloft.net>
Cc: msipkema@sipkema-digital.com, cfriesen@nortelnetworks.com,
       hzhong@cisco.com, jst1@email.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, davem@redhat.com
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041007230019.GA31684@mark.mielke.cc>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	msipkema@sipkema-digital.com, cfriesen@nortelnetworks.com,
	hzhong@cisco.com, jst1@email.com, linux-kernel@vger.kernel.org,
	alan@lxorguk.ukuu.org.uk, davem@redhat.com
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com> <41658C03.6000503@nortelnetworks.com> <015f01c4acbe$cf70dae0$161b14ac@boromir> <4165B9DD.7010603@nortelnetworks.com> <20041007150035.6e9f0e09.davem@davemloft.net> <000901c4acc4$26404450$161b14ac@boromir> <20041007152400.17e8f475.davem@davemloft.net> <20041007224242.GA31430@mark.mielke.cc> <20041007154722.2a09c4ab.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007154722.2a09c4ab.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 03:47:22PM -0700, David S. Miller wrote:
> On Thu, 7 Oct 2004 18:42:42 -0400
> Mark Mielke <mark@mark.mielke.cc> wrote:
> > Sure, it's nice to demand that people
> > upgrade to a later version of Perl. Guess what? It isn't happening. It
> > will be another year or two before we can guarantee people have Perl
> > 5.006 on their system.
> If those people are tepid about upgrading perl, I think it would
> be even less likely that they would upgrade their kernels.

Good practical point for the here and now. :-)

The discussion, though, is more about what it should have been.
The combined frustrations of many of us.

To colour the discussion a bit, many of us have had these same
frustrations with Sun, and HP on various issues.

Just say "it's a bug, but one we have chosen not to fix for practical
reasons." That would have kept me out of this discussion. Saying the
behaviour is correct and that POSIX is wrong - that raises hairs -
both the question kind, and the concern kind.

Cheers,
mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

