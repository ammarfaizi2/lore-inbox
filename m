Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268070AbUI1WPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268070AbUI1WPc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 18:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268072AbUI1WNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 18:13:32 -0400
Received: from peabody.ximian.com ([130.57.169.10]:38577 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268074AbUI1WL1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 18:11:27 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Robert Love <rml@novell.com>
To: Ray Lee <ray-lk@madrabbit.org>
Cc: John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <1096407553.5177.41.camel@issola.madrabbit.org>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
	 <20040928120830.7c5c10be.akpm@osdl.org>  <1096404035.30123.22.camel@vertex>
	 <1096404433.4911.57.camel@betsy.boston.ximian.com>
	 <1096407553.5177.41.camel@issola.madrabbit.org>
Content-Type: text/plain
Date: Tue, 28 Sep 2004 18:10:06 -0400
Message-Id: <1096409406.4911.101.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 14:39 -0700, Ray Lee wrote:

> It's just as easy to pass crap via ioctl() as write().

The ioctl() at least forces you to break up your calls into request and
argument pairs.  And as the requests are inotify-based preprocessor
defines, at least that half of the equation is impossible to mess up.

In other words, ioctl() is slightly more structured than write(), which
is utterly non-structured.

	Robert Love


