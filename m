Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131349AbRCWTPv>; Fri, 23 Mar 2001 14:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131352AbRCWTPo>; Fri, 23 Mar 2001 14:15:44 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:19880 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131351AbRCWTPe>; Fri, 23 Mar 2001 14:15:34 -0500
Message-ID: <3ABB9F25.9FF61FF8@coplanar.net>
Date: Fri, 23 Mar 2001 14:08:21 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Dax Kelson <dax@gurulabs.com>
CC: Gerhard Mack <gmack@innerfire.net>,
        Bob Lorenzini <hwm@newportharbornet.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Worm (fwd)
In-Reply-To: <Pine.LNX.4.30.0103231150460.18026-100000@duely.gurulabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dax Kelson wrote:

> Gerhard Mack said once upon a time (Fri, 23 Mar 2001):
>
> > On Fri, 23 Mar 2001, Bob Lorenzini wrote:
> >
> > > I'm annoyed when persons post virus alerts to unrelated lists but this
> > > is a serious threat. If your offended flame away.
> >
> > This should be a wake up call... distributions need to stop using product
> > with consistently bad security records.
>
> This TSIG bug in BIND 8 that is being exploited was added to BIND 8 by the
> same team who wrote BIND 9.
>
> In fact the last two major remote root compromises (TSIG and NXT) for BIND
> 8 was in code added to BIND 8 by the BIND 9 developers.

You could say new code in general causes security holes... don't fix it
and you won't break it.   There is the security principle of least privilege
though...
RH7 (and earlier I think) run bind drops root and runs as user named after
opening
a listening socket, so I don't think a bind
compromise could retrieve the /etc/shadow file and modify system binaries...
and RH7.1(beta) will use capabilities to furthur restrict privileges given to
bind(v9).
(not root ever)

