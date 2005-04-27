Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVD0Q7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVD0Q7F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 12:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVD0Q7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 12:59:05 -0400
Received: from quechua.inka.de ([193.197.184.2]:27053 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261808AbVD0Q6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 12:58:52 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20050427151758.GE1957@mail.shareable.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DQprb-00024N-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 27 Apr 2005 18:58:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050427151758.GE1957@mail.shareable.org> you wrote:
> If we have transactions, then I'd like to be able to do this from a shell:
...
> I'd also like to write inside a single C program:

perhaps you will need to use plan9 or hurd? :)

Because this pretty much virtualisation/snapshots. Anyway, it would be a
nice thing to have, for sure (I am not sure if all the technical
implications like deadlocks and serialisations can be solved in a unix
compatible manner (and especially for at least more than one local and
networked file system).

> It's useful, and there is no good reason to disallow that.

There might be no good reasons, but a lot of hard problems.

> Nonetheless, there's a need for some kind of transaction handles.  A
> file descriptor representing a transaction seems like a natural fit.

Yes, that might be a good thing, beacause it can be passed, inherited and
access controled and possesed.

Greetings
Bernd
