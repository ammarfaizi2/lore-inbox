Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290739AbSBLCsi>; Mon, 11 Feb 2002 21:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290741AbSBLCsY>; Mon, 11 Feb 2002 21:48:24 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:1796 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S290740AbSBLCsM>; Mon, 11 Feb 2002 21:48:12 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 11 Feb 2002 18:49:26 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: David Mosberger <davidm@hpl.hp.com>
cc: "David S. Miller" <davem@redhat.com>, <anton@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <zippel@linux-m68k.org>
Subject: Re: thread_info implementation
In-Reply-To: <15464.32354.452126.182563@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.40.0202111845460.1567-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2002, David Mosberger wrote:

> >>>>> On Mon, 11 Feb 2002 18:22:08 -0800 (PST), "David S. Miller" <davem@redhat.com> said:
>
>   DavidM> I implemented the thread_info stuff, and I checked out the
>   DavidM> performance, have you?
>
> So why don't you share the results?  Perhaps then I can see the light,
> too.  With the exception of task coloring, the thread_info is strictly
> more work and it's possible to do task coloring without thread_info.

This one does task colouring and stack pointer jittering for x86 :

http://www.xmailserver.org/linux-patches/misc.html#TskStackCol

Also i think Manfred Spraul has something that does task colouring. It has
been tested by a guy in fujitsu ( Japan ) on 8 way machines by giving pretty
good results. The stack jittering part seemed not to give too much
improvements though ...




- Davide


