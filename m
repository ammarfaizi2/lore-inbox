Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264589AbRFZLIO>; Tue, 26 Jun 2001 07:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264635AbRFZLIF>; Tue, 26 Jun 2001 07:08:05 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:41231 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S264589AbRFZLHu>; Tue, 26 Jun 2001 07:07:50 -0400
Date: Tue, 26 Jun 2001 14:07:42 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org,
        Florian Lohoff <flo@rfc822.org>
Subject: Re: Oops in iput
Message-ID: <20010626140742.V1503@niksula.cs.hut.fi>
In-Reply-To: <20010625201612.A701@paradigm.rfc822.org> <20010625194213.J18856@redhat.com> <20010626110933.R1503@niksula.cs.hut.fi> <20010626115651.A9176@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010626115651.A9176@redhat.com>; from sct@redhat.com on Tue, Jun 26, 2001 at 11:56:51AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2001 at 11:56:51AM +0100, you [Stephen C. Tweedie] claimed:
> Hi,
> 
> On Tue, Jun 26, 2001 at 11:09:33AM +0300, Ville Herva wrote:
> 
> > Well, I for one use the 2.2 ide patches extensively (on almost all of my
> > machines, including a heavy-duty backup server)
> 
> It is highly hardware-dependent.  A huge amount of effort was spent
> early in 2.4 getting blacklists and hardware tweaks right to work
> around problems with specific chipsets with ide udma.  Just because it
> works for one person doesn't give you any confidence that it won't
> trash data for somebody else.

Well, the report said 'Intel BX chipset' - that's as solid as chipsets get
(to loosely quote Alan). Almost all of my boxes are BX (one has HPT366 in
addition, and another one was changed to Via686a recently), and I imagine
that BX gets most testing since it is very common chipset. Moreover, it only
does UDMA33, not any fancy 66 or 100 stuff (although I haven't had problems
with those either on HPT366, HPT370 nor 686a).

As said, it could be the ide patch, but surely there are other just as
likely suspects as well.


-- v --

v@iki.fi
