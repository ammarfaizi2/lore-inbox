Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285471AbRLSUTa>; Wed, 19 Dec 2001 15:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285467AbRLSUTZ>; Wed, 19 Dec 2001 15:19:25 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:49419 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S285466AbRLSUSt>; Wed, 19 Dec 2001 15:18:49 -0500
Date: Wed, 19 Dec 2001 12:21:39 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ben LaHaise <bcrl@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        <linux-aio@kvack.org>
Subject: Re: aio
In-Reply-To: <20011219135708.A12608@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.40.0112191157030.1529-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2001, Ben LaHaise wrote:

> Thanks for the useful feedback on the userland interface then.  Evidently
> nobody cares within the community about improving functionality on a
> reasonable timescale.  If this doesn't change soon, Linux is doomed.

Ben, maybe it's true, nobody cares :( This could be either bad or good.
On one side it could be good because this means that everyone is happy
with the kernel performance level and this could be due the fact that real
world loads does not put their applications under stress. It could be bad
because it's possible that exist applications that are currently under
stress ( yes ), but their developers do not understand that by using
different interfaces they can improve their software ( or they simply do
not understand that the application is under stress ). Or maybe application
developers are not in lk. Or maybe they're not willing to rewrite/experiment
new APIs. On one side i understand that you can have an intrinsic attitude
to push/defend your patch, while one the other side i can agree with the
Linus point to have some kind of broad discussion/adoption about it.
But if applications developers are not in this list there won't be a broad
discussion and if the patch does not go inside the mainstream kernel
"external" applications developers are not going to use it. The Linus
point could be: "why do i have to merge a new api that has had a so cold
discussion/adoption inside lk ?".
Yes egg-chicken draws the picture very well.



- Davide



