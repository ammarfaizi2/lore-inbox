Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263437AbTCNSSc>; Fri, 14 Mar 2003 13:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263438AbTCNSSc>; Fri, 14 Mar 2003 13:18:32 -0500
Received: from havoc.daloft.com ([64.213.145.173]:31961 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S263437AbTCNSS3>;
	Fri, 14 Mar 2003 13:18:29 -0500
Date: Fri, 14 Mar 2003 13:29:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Never ever use word BitKeeper if Larry does not like you
Message-ID: <20030314182912.GA1873@gtf.org>
References: <Pine.LNX.4.44.0303141120240.8584-100000@bushido> <1047659289.2566.109.camel@sisko.scot.redhat.com> <20030314163727.GE8937@work.bitmover.com> <Pine.LNX.4.50.0303140856340.1903-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303140856340.1903-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 09:09:15AM -0800, Davide Libenzi wrote:
> Ok, let's try again. Because honestly I'm pretty sick of this BK saga on
> lkml. It's maybe time to understand if people here is against Larry or
> against the BK license itself. It seems to me that there's the request of
> a read-only tool that is able to read BK repositories to fetch the latest
> kernel trees. I proposed before to Larry and to lkml to have Larry to
> release a read-only ( read-only here means, able only to fetch sources and
> related information ) BK binary under different licensing. Why this
> couldn't solve the problem if Larry and the anti-BK movement will find an
> agreement on the license ? Larry, is it possible to release such tool
> under a less strict license ?

No.

Because, in order to properly export data, you have to not understand
the BK file format, but you also have precisely follow BK's method
for creating the "weave" of changesets which produces a valid [GNU
patch / changeset / whatever].

Thus, even to have an open source BK export tool requires that key
BK algorithms be open sourced.

	Jeff



