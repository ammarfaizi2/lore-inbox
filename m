Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUCINlM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 08:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbUCINlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 08:41:12 -0500
Received: from p68.rivermarket.wintek.com ([208.13.56.68]:56828 "EHLO
	dust.p68.rivermarket.wintek.com") by vger.kernel.org with ESMTP
	id S261928AbUCINlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 08:41:09 -0500
Date: Tue, 9 Mar 2004 08:43:40 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: rihad <rihad@mail.ru>
Cc: Greg KH <greg@kroah.com>, linux-kernel-digest@lists.us.dell.com,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] udev 021 release
In-Reply-To: <404D9966.6080903@mail.ru>
Message-ID: <Pine.LNX.4.58.0403090841310.11579@dust.p68.rivermarket.wintek.com>
References: <20040303153403.21649.81059.Mailman@linux.us.dell.com>
 <4048D503.10808@mail.ru> <20040309081948.GI22057@kroah.com> <404D9966.6080903@mail.ru>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2004, rihad wrote:

[Snip]

> Does the devfs/udev /dev entry get removed when doing rmmod? I though 
> not. But since the module isn't there anymore, doing mount /dev/cdrom 
> /cdrom would give "No such device". Not a problem per se, but then 
> probably rmmod -a isn't as a wise thing to do with udev as it is with 
> devfs. Bad.

See past linux-kernel threads on how problematic module unloading is (and
how insanely hard it'd be to fix those problems).  You really shouldn't be
using rmmod unless you're a developer as it is.

-- 
Alex Goddard
agoddard at purdue dot edu
