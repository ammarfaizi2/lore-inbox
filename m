Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVDXAC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVDXAC0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 20:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVDXAC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 20:02:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:2007 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262189AbVDXACX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 20:02:23 -0400
Date: Sat, 23 Apr 2005 17:01:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Juergen Kreileder <jk@blackdown.de>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: 2.6.12-rc2-mm3
Message-Id: <20050423170152.6b308c74.akpm@osdl.org>
In-Reply-To: <877jj1aj99.fsf@blackdown.de>
References: <20050411012532.58593bc1.akpm@osdl.org>
	<87wtr8rdvu.fsf@blackdown.de>
	<87u0m7aogx.fsf@blackdown.de>
	<1113607416.5462.212.camel@gaston>
	<877jj1aj99.fsf@blackdown.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Kreileder <jk@blackdown.de> wrote:
>
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > On Fri, 2005-04-15 at 20:23 +0200, Juergen Kreileder wrote:
> >> Juergen Kreileder <jk@blackdown.de> writes:
> >>
> >>> Andrew Morton <akpm@osdl.org> writes:
> >>>
> >>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> >>>
> >>> I'm getting frequent lockups on my PowerMac G5 with rc2-mm3.
> >>
> >> I think I finally found the culprit.  Both rc2-mm3 and rc1-mm1 work
> >> fine when I reverse the timer-* patches.
> >>
> >> Any idea?  Bug in my ppc64 gcc?
> >
> > Or a bug in those patches,

(cc'ed Oleg)

> Probably.  I've tried a different toolchain now (3.4.3), didn't help.

That is bad news.

I wonder why you're the only person who has noticed this.

How frequent are the lockups?

Is it possible to perform any additional debugging?

Do you think there's anything unusual in your driver lineup or in your
workload which would cause you to be the only person who is observing this?

