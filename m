Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264803AbSJOSCT>; Tue, 15 Oct 2002 14:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264805AbSJOSCS>; Tue, 15 Oct 2002 14:02:18 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:40334 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264803AbSJOSCR>; Tue, 15 Oct 2002 14:02:17 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 15 Oct 2002 11:16:16 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
In-Reply-To: <20021015135048.F14596@redhat.com>
Message-ID: <Pine.LNX.4.44.0210151114070.1554-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, Benjamin LaHaise wrote:

> On Tue, Oct 15, 2002 at 01:38:53PM -0400, Shailabh Nagar wrote:
> > So I guess the question would now be: whats keeping /dev/epoll from
> > being included in the kernel given the time left before the feature freeze ?
>
> We don't need yet another event reporting mechanism as /dev/epoll presents.
> I was thinking it should just be its own syscall but report its events in
> the same way as aio.

Yes, Linus ( like myself ) hates magic inodes inside /dev. At that time it
was the fastest way to have a kernel interface exposed w/out having to beg
for a syscall. I'm all for a new syscall obviously, and IMHO /dev/epoll
might be a nice complement to AIO for specific applications.




- Davide


