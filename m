Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284807AbRLRTq0>; Tue, 18 Dec 2001 14:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284860AbRLRTpM>; Tue, 18 Dec 2001 14:45:12 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:44782 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S284843AbRLRTn5>;
	Tue, 18 Dec 2001 14:43:57 -0500
Date: Tue, 18 Dec 2001 14:43:50 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Benjamin LaHaise <bcrl@redhat.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33.0112180843510.2867-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0112181425210.7996-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Dec 2001, Linus Torvalds wrote:

> Where are the negative comments from Al? (Al _always_ has negative
> comments and suggestions for improvements, don't try to say that he also
> liked it unconditionally ;)

Heh.

Aside of a _big_ problem with exposing async API to userland (for a
lot of reasons, including usual quality of async code in general and
event-drivel one in particular) there is more specific one - Ben's
long-promised full-async writepage() and friends.  I'll believe it
when I see it and so far it didn't appear.

So for the time being I'm staying the fsck out of that - I don't like
it, but I'm sick and tired of this sort of religious wars.

