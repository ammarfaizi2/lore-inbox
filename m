Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751043AbWFFD2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWFFD2Z (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 23:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWFFD2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 23:28:25 -0400
Received: from quechua.inka.de ([193.197.184.2]:1734 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751042AbWFFD2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 23:28:24 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org, diegocg@gmail.com
Subject: Re: [RFC] Update sysctl documentation
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060606035833.bee909af.diegocg@gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1FnSEw-0005MC-00@calista.eckenfels.net>
Date: Tue, 06 Jun 2006 05:28:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja <diegocg@gmail.com> wrote:
> First of all: the formatting I've choosen is to recreate the structure
> of /proc/sys/* and put the documentation for every value in a separated
> file, so I have things like Documentation/sysctl/vm/swappiness or
> Documentation/sysctl/net/ipv4/locktime.

I am not sure if that is a good idea, since a lot of the sysctl params in a
directory reference each other or depend on the settings. If you want to
explain concepts (neighbour cache) one sentence can explain multiple
parameters. "wait for x and try y times..."

In the net case for example ipv4/conf/* is such a usefull cluster,
especially since there is this dynamic all/default/<iface> functionality.

And I also think you should not create TODO single-line files, better
collect those in a central TODO file (for each directory), that is less
frustrating for the reader (and still preserves your great work on updating
the list)

BTW: perhaps some markup would be nice so we can create the man pages out of
it? One thing I am impressed with in the BSD world is the existence of
up-to-date Kernel ABI man pages.

Gruss
Bernd

PS: and sorry for the dropped CC, I am not impolite, only stupid.
