Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267416AbTGHPP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267364AbTGHPP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:15:29 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:22916 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263633AbTGHPNh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:13:37 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 8 Jul 2003 08:20:36 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Eric Varsanyi <e0216@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll vs stdin/stdout
In-Reply-To: <20030708135109.GA15515@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307080819140.4544@bigblue.dev.mcafeelabs.com>
References: <20030707154823.GA8696@srv.foo21.com>
 <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com>
 <20030707194736.GF9328@srv.foo21.com> <Pine.LNX.4.55.0307071511550.4704@bigblue.dev.mcafeelabs.com>
 <Pine.LNX.4.55.0307071624550.4704@bigblue.dev.mcafeelabs.com>
 <20030708003247.GB12127@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307071730190.3524@bigblue.dev.mcafeelabs.com>
 <20030708005226.GD12127@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307071802360.3531@bigblue.dev.mcafeelabs.com>
 <20030708123421.GB14827@mail.jlokier.co.uk> <20030708135109.GA15515@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003, Jamie Lokier wrote:

> Doh!  I'm sorry.  I forgot that the lookup key is actually (epoll_fd,
> file *, fd).
>
> So all I said in the parent mail about problems with fds shared among
> multiple processes is nonsense - they will each have a different
> epoll_fd, so maintain separate epoll state.
>
> Remember not to take me seriously in future.
> (Oh, you weren't... :)

I was indeed wondering what stuff you were smoking :)



- Davide

