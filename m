Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268066AbUI1WHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268066AbUI1WHj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 18:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268070AbUI1WGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 18:06:47 -0400
Received: from peabody.ximian.com ([130.57.169.10]:33969 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268066AbUI1WE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 18:04:58 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Robert Love <rml@novell.com>
To: Ray Lee <ray-lk@madrabbit.org>
Cc: John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <1096408235.5177.49.camel@issola.madrabbit.org>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
	 <1096403167.30123.5.camel@vertex>
	 <1096405848.5177.15.camel@issola.madrabbit.org>
	 <1096406467.30123.42.camel@vertex>
	 <1096407301.4911.79.camel@betsy.boston.ximian.com>
	 <1096408235.5177.49.camel@issola.madrabbit.org>
Content-Type: text/plain
Date: Tue, 28 Sep 2004 18:03:37 -0400
Message-Id: <1096409017.4911.95.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 14:50 -0700, Ray Lee wrote:

> I'm afraid I'm not seeing the complexity argument. Do you have other
> concerns regarding dynamic lengths?

You _do_ see the complexity, you just don't that think it matters.

It forces more complexity on user-space (as least as much as you have
shown) and even more in the kernel (due partly to the current very
simple event code in place that needs the buffer to be a multiple of the
struct size, etc.).

Personally, I don't know if it matters.  John and I have both said that
we will look into going to a dynamic filename.

Also, I am sure that John will take a patch, if you are so inclined.

	Robert Love


