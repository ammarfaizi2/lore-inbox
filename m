Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263356AbTC0Rtj>; Thu, 27 Mar 2003 12:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263359AbTC0RtX>; Thu, 27 Mar 2003 12:49:23 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:50581 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263356AbTC0Rst>; Thu, 27 Mar 2003 12:48:49 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 27 Mar 2003 10:11:07 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "David S. Miller" <davem@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Obsolete messages ...
In-Reply-To: <1048774874.19677.0.camel@rth.ninka.net>
Message-ID: <Pine.LNX.4.50.0303271008330.2009-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.50.0303261857290.970-100000@blue1.dev.mcafeelabs.com>
 <1048774874.19677.0.camel@rth.ninka.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003, David S. Miller wrote:

> On Wed, 2003-03-26 at 18:57, Davide Libenzi wrote:
> > Any CONFIG_DROP_FREAKIN_OBSOLETE_MSGS (SO_BSDCOMPAT,bdflush,...) anywhere
> > soon in 2.5.67 ? :)
>
> If you fix the apps, the messages go away.  In fact, you want to know
> that you have unfixed apps on your box when you run these kernels so
> I'd say the messages should stay even well into early 2.6.x

I know David, I already did ( named and /etc/inittab in my case ). My idea
was to have something like warn_obsolete(char *) to be used in all places
where necessary, and have a config option ( on by default ) that chop
messages in off case.



- Davide

