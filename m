Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbUBQJiH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 04:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbUBQJiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 04:38:06 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:57284 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S264534AbUBQJiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 04:38:05 -0500
Date: Tue, 17 Feb 2004 04:37:45 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       lhcs-devel@lists.sourceforge.net, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][2.6-mm] split drain_local_pages 
In-Reply-To: <20040217073038.33DA62C594@lists.samba.org>
Message-ID: <Pine.LNX.4.58.0402170437170.12214@montezuma.fsmlabs.com>
References: <20040217073038.33DA62C594@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004, Rusty Russell wrote:

> In message <Pine.LNX.4.58.0402161720390.11793@montezuma.fsmlabs.com> you write:
> > CPU hotplug core needs to pass a cpu parameter to drain_local_pages, it's
> > safe to call __drain_local_pages if the cpu being drained is offline. The
> > semantics for drain_local_pages do not change.
>
> I prefer this version: it gets the #ifdef correct too.

Indeed, i favour your version too.
