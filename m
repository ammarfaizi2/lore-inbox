Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbSKNR0D>; Thu, 14 Nov 2002 12:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265140AbSKNR0D>; Thu, 14 Nov 2002 12:26:03 -0500
Received: from otter.mbay.net ([206.55.237.2]:41226 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S265139AbSKNR0B>;
	Thu, 14 Nov 2002 12:26:01 -0500
Date: Thu, 14 Nov 2002 09:32:33 -0800 (PST)
From: John Alvord <jalvo@mbay.net>
To: Andi Kleen <ak@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: module mess in -CURRENT
In-Reply-To: <p731y5owj0x.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.20.0211140929080.28420-100000@otter.mbay.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Nov 2002, Andi Kleen wrote:

> Linus Torvalds <torvalds@transmeta.com> writes:
> 
> > (There are some other patches I'm still thinking about, notably kprobes
> > and posix timers, but other than that my plate is fairly empty froma
> > feature standpoint. And the kexec stuff I want others to test, at least
> > now it's palatable to me).
> 
> How about the nanosecond stat stuff? It is needed for reliable make.
> 
> If I sent you a patch would you still consider it? It is not that intrusive, 
> but needs straightforward editing in all file systems.
> 
Owens' kbuild-2.5 handled it a different way and didn't need exact
timings. That is especially important since nanosecond time accuracy is
impossible if you are handling a collection of machines doing the
work. NTP is accurate, but not that accurate.

john

