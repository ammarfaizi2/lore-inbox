Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSDSHns>; Fri, 19 Apr 2002 03:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311735AbSDSHnr>; Fri, 19 Apr 2002 03:43:47 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:34280 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S311710AbSDSHnr>; Fri, 19 Apr 2002 03:43:47 -0400
Date: Fri, 19 Apr 2002 03:43:38 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: "J.A. Magallon" <jamagallon@able.es>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>, Andrew Morton <akpm@zip.com.au>,
        Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam1
In-Reply-To: <200204190136.15978.Dieter.Nuetzel@hamburg.de>
Message-ID: <Pine.LNX.4.44.0204190340450.20646-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 Apr 2002, Dieter [iso-8859-15] Nützel wrote:

> No uptodate O(1) patch for 2.4. Very sad. So there isn't any change to
> see a current preemption patch on top of vm33 and O(1).
>
> [...] 
> I'm under the impression that "all" development is focused on 2.5.x, now.

well, 2.5's scheduler bits were pretty much in flux in the past two months
or so, partly due to the preemption feature going in. And there are a
number of other changes in the pipeline as well. So what makes sense for
2.4 is Robert's plan: to backport O(1)+preempt once 2.5 is slowing down,
that way we get the proper testing of both components, instead of a
separated scheduler patch that doesnt even exist in that form in 2.5.

	Ingo

