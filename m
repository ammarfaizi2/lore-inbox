Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310858AbSCSXzQ>; Tue, 19 Mar 2002 18:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310913AbSCSXzH>; Tue, 19 Mar 2002 18:55:07 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:65036 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S310858AbSCSXyr>; Tue, 19 Mar 2002 18:54:47 -0500
Date: Tue, 19 Mar 2002 23:54:34 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: "David S. Miller" <davem@redhat.com>
cc: <lm@bitmover.com>, <pavel@suse.cz>, <davej@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper licence issues
In-Reply-To: <20020319.154502.18227426.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0203192353540.1903-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, David S. Miller wrote:

>    Hey Dave, are you suggesting that no such exploits exist in Red Hat's
>    rpm system?  In order for that to be true, rpm would have to be making
>    sure that each and every directory along any path that it writes is
>    not writable except by priviledged users.  I just checked, it doesn't.
>
> We should be using mktemp() to make temporary files, and if we don't
> that is a bug and I'd ask you to please submit a bugzilla entry about
> it if so because that would be a serious hole.

I trust you mean mkstemp(3) here (or mktemp(1), but not
much of RPM is in shell).

Matthew.

