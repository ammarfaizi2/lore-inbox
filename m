Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTFKWbe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 18:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbTFKWbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 18:31:34 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:56859 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261300AbTFKWbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 18:31:33 -0400
Date: Wed, 11 Jun 2003 15:41:22 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-mm8: freeze after starting X
Message-Id: <20030611154122.55570de0.akpm@digeo.com>
In-Reply-To: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jun 2003 22:45:17.0370 (UTC) FILETIME=[213BB1A0:01C3306B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@serpentine.com> wrote:
>
> I just upgraded from -mm3 (which I'd been running solidly for over a
> week) to -mm8, and find that the system freezes hard after I start the X
> server.  After X starts, lifetime varies from zero to maybe 20 seconds
> of app launching, then everything locks up.

You might try reverting
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm8/broken-out/pci-init-ordering-fix.patch

> At this point, the machine is still pingable, but daemons like sshd
> don't respond, and I can't see any logs.  After a reboot back to -mm3,
> there's nothing suspicious in /var/log.

Something oopsed I'd say.  You using radeon?  That seems pretty oopsy
lately.


