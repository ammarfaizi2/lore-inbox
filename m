Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261928AbSIYHNG>; Wed, 25 Sep 2002 03:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261929AbSIYHNG>; Wed, 25 Sep 2002 03:13:06 -0400
Received: from angband.namesys.com ([212.16.7.85]:8108 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261928AbSIYHNF>; Wed, 25 Sep 2002 03:13:05 -0400
Date: Wed, 25 Sep 2002 11:18:20 +0400
From: Oleg Drokin <green@namesys.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: cmpxchg in 2.5.38
Message-ID: <20020925111820.A23225@namesys.com>
References: <20020925010044.A4464@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020925010044.A4464@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Sep 25, 2002 at 01:00:44AM -0400, Pete Zaitcev wrote:
> The cmpxchg() is used in kernel/pid.c:next_free_map():
> It is implemented on alpha, i386, ia64, ppc64, ppc, sparc64,
> x86_64, but not on mips, cris, arm, s390, s390x, sparc, sh, parisc.
> Do all architectures have to have it?

Ingo said that arches that cannot do cmpxchg in hardware should
provide spinlock-based version.

Bye,
    Oleg
