Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131842AbRC1O6C>; Wed, 28 Mar 2001 09:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131836AbRC1O5x>; Wed, 28 Mar 2001 09:57:53 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:40978 "EHLO mailout05.sul.t-online.com") by vger.kernel.org with ESMTP id <S131832AbRC1O5r>; Wed, 28 Mar 2001 09:57:47 -0500
Date: Wed, 28 Mar 2001 17:56:47 +0200
From: Andreas Rogge <lu01@rogge.yi.org>
To: Hacksaw <hacksaw@hacksaw.org>, james <jdickens@ameritech.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Ideas for the oom problem 
Message-ID: <64000000.985795007@hades>
In-Reply-To: <200103281438.f2SEc4Q03910@habitrail.home.fools-errant.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, March 28, 2001 09:38:04 -0500 Hacksaw <hacksaw@hacksaw.org> 
wrote:
>
> Deciding what not to kill based on who started it seems like a bad idea.
> Root  can start netscape just as easily as any user, but if the choice of
> processes  to kill is root's netscape or a user's experimental database,
> I'd want the  netscape to go away.

root does not use netscape -FULLSTOP-

Anyone working as root is (sorry) an idiot! root's processes are normally
quite system-relevant and so they should never be killed, if we can avoid 
it.
There can however be processes owned by other users which shouldn't be
killed in OOM-Situation, but generally root's processes are more important
than a normal user's processes.
What about doing something really critical to avoid the upcoming OOM-situ
and get your shell killed because you were to slow?

--
Andreas Rogge <lu01@rogge.yi.org>
Available on IRCnet:#linux.de as Dyson
