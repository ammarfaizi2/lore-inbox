Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267728AbUG2QZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267728AbUG2QZp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267481AbUG2QPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:15:02 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:36078 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268374AbUG2QF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:05:57 -0400
Date: Thu, 29 Jul 2004 12:09:29 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Mika Bostrom <bostik+lkml@bostik.iki.fi>
Cc: Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL and XFS on
 4KSTACKS=n
In-Reply-To: <20040729154224.GA3030@bostik.iki.fi>
Message-ID: <Pine.LNX.4.58.0407291205590.8976@montezuma.fsmlabs.com>
References: <20040720114418.GH21918@email.archlab.tuwien.ac.at>
 <40FD0A61.1040503@xfs.org> <40FD2E99.20707@mnsu.edu> <20040720195012.GN14733@fs.tum.de>
 <20040729060900.GA1946@frodo> <20040729154224.GA3030@bostik.iki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004, Mika Bostrom wrote:

>   Now, the reason this can't be any kind of bugreport is clear:
>   1) kernel is tainted
>   2) VMWare's modules are not yet updated to cope with 2.6.7 kernel
>
>   So until VMWare updates their product, I consider this a bug in their
> modules. When they do, I intend to test 4k stacks again. If the hangs
> continue, then I shall see with their support whether it can be tracked
> to their code or not.
>
>   But at least at the moment if you wish to use VMWare and XFS, using 4k
> stacks is, in my experience, asking for trouble.

Given that XFS and 4k stacks has known issues perhaps it isn't a fault of
VMWare. I've been using VMWare 4 with 4K stacks running linux, netbsd and
win2k on a system with a 30day uptime, i'm using ext3 on 2.6.7-rc3-mm2.
