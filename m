Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261853AbTCLTTi>; Wed, 12 Mar 2003 14:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261877AbTCLTTi>; Wed, 12 Mar 2003 14:19:38 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:34222 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261853AbTCLTTf>; Wed, 12 Mar 2003 14:19:35 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 12 Mar 2003 11:39:31 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Martin Waitz <tali@admingilde.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
In-Reply-To: <20030312192122.GA1340@admingilde.org>
Message-ID: <Pine.LNX.4.50.0303121133280.991-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com>
 <XFMail.20030311171056.pochini@shiny.it> <20030312180819.GB27366@admingilde.org>
 <Pine.LNX.4.50.0303121027560.991-100000@blue1.dev.mcafeelabs.com>
 <20030312192122.GA1340@admingilde.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Mar 2003, Martin Waitz wrote:

> On Wed, Mar 12, 2003 at 10:30:54AM -0800, Davide Libenzi wrote:
> > > in some situations, ET simply has wrong semantics.
> >
> > IMO ET has perfectly nice semantics. The fact that ppl fail to understand
> > it does not make it automatically wrong. If things not understood would
> > have been flagged as wrong, we would be still living in caves.
>
> if ppl don't understand an API, it usually is flawed.

It's not the API that ppl does not understand, the API is the same. It's
the Edge Triggered event distribution architecture. The equation :

"not understood architecture" == "flawed architecture"

is false in all my books.


> but that's not the point here, i just wanted to point out that there are
> situations that are easier to solve with one or the other semantics.
> and there /is/ a need for level-based events.

That's a completely different thing. The new epoll gives you both
behaviours on a per-fd basis.




- Davide

