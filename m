Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUJAPsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUJAPsB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 11:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUJAPsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 11:48:01 -0400
Received: from peabody.ximian.com ([130.57.169.10]:3018 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S263769AbUJAPqG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 11:46:06 -0400
Subject: Re: [patch] make dnotify compile-time configurable
From: Robert Love <rml@novell.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: mpm@selenic.com, ttb@tentacle.dhs.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, gamin-list@gnome.org
In-Reply-To: <20041001083110.76a58fd2.rddunlap@osdl.org>
References: <1096611874.4803.18.camel@localhost>
	 <20041001151124.GQ31237@waste.org>
	 <1096644076.7676.6.camel@betsy.boston.ximian.com>
	 <20041001083110.76a58fd2.rddunlap@osdl.org>
Content-Type: text/plain
Date: Fri, 01 Oct 2004 11:44:39 -0400
Message-Id: <1096645479.7676.15.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 08:31 -0700, Randy.Dunlap wrote:

> I'd rather see inotify additions and dnotify config options kept
> separate.  They may serve a similar purpose, but inotify doesn't
> replace the dnotify API.  If the latter were true, combining
> them would make sense IMO.

I'm not really following.

Whether or not dnotify is a configuration option is separate, and could
go into the kernel either way.

But what matters if our inotify patch also carries the change?  People
with inotify definitely DO want this patch, because they don't need
dnotify.  Not much uses dnotify--it is a pain to use--and inotify
replaces its functionality.

It is also a practical move: the diffs conflict.

	Robert Love


