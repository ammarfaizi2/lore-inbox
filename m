Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268051AbUI1VWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268051AbUI1VWE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 17:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268049AbUI1VWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 17:22:04 -0400
Received: from peabody.ximian.com ([130.57.169.10]:6065 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268039AbUI1VV2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 17:21:28 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Robert Love <rml@novell.com>
To: Ray Lee <ray-lk@madrabbit.org>
Cc: John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <1096405848.5177.15.camel@issola.madrabbit.org>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
	 <1096403167.30123.5.camel@vertex>
	 <1096405848.5177.15.camel@issola.madrabbit.org>
Content-Type: text/plain
Date: Tue, 28 Sep 2004 17:20:03 -0400
Message-Id: <1096406403.4911.73.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 14:10 -0700, Ray Lee wrote:

> So, got me. I believe there is some minor confusion going on.

I think you are both just talking about different things.  John was
confused about what you were saying, I think.

Right now we limit the filename returned to 256 characters.

And file names can be as large as PATH_MAX-1 (minus one for the root
slash).

	Robert Love


