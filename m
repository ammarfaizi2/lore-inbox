Return-Path: <linux-kernel-owner+willy=40w.ods.org-S281555AbUKAWdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S281555AbUKAWdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 17:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S377339AbUKAWdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:33:24 -0500
Received: from peabody.ximian.com ([130.57.169.10]:8094 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S311627AbUKAUKK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 15:10:10 -0500
Subject: Re: [RFC][PATCH] inotify 0.15
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       bkonrath@redhat.com, greg@kroah.com
In-Reply-To: <1099330316.12182.2.camel@vertex>
References: <1099330316.12182.2.camel@vertex>
Content-Type: text/plain
Date: Mon, 01 Nov 2004 15:07:49 -0500
Message-Id: <1099339669.31022.36.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-01 at 12:31 -0500, John McCutchan wrote:

> In this release of inotify I have added a new ulimit for the
> number of watches a particular user can have. I am interested
> in peoples response to this addition and any alternative solutions.
> 
> Here is release 0.15.0 of inotify. Attached is a patch to 2.6.9

By and by, people using 2.6.10-rc1 or -mm or whatever will find that
several interfaces used by this patch coincidentally changed.

So I thought I'd point you all at an updated 2.6.10-rc1 patch:

http://www.kernel.org/pub/linux/kernel/people/rml/inotify/v2.6/0.15/

Which might be easier.

	Robert Love


