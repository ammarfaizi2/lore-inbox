Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268052AbUI1Vwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268052AbUI1Vwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 17:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268059AbUI1Vwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 17:52:50 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:41165 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S268052AbUI1Vug
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 17:50:36 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Ray Lee <ray-lk@madrabbit.org>
To: Robert Love <rml@novell.com>
Cc: John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <1096407301.4911.79.camel@betsy.boston.ximian.com>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
	 <1096403167.30123.5.camel@vertex>
	 <1096405848.5177.15.camel@issola.madrabbit.org>
	 <1096406467.30123.42.camel@vertex>
	 <1096407301.4911.79.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Organization: http://madrabbit.org/
Date: Tue, 28 Sep 2004 14:50:35 -0700
Message-Id: <1096408235.5177.49.camel@issola.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 17:35 -0400, Robert Love wrote:
> The POSIX absolute maximum is PATH_MAX for the entire path, which means
> that a legal filename could theoretically be PATH_MAX-1 (a file in the
> root directory).  But maybe in practice this is never an issue.

Ah, okay.

> We still have the issue where 256 is much larger than the average file.

Yes.

> But, as I have said before, I am _for_ keeping the thing static,
> although I acknowledge all the points about going dynamic.

I'm afraid I'm not seeing the complexity argument. Do you have other
concerns regarding dynamic lengths?

Ray

