Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267904AbUI1Ut0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267904AbUI1Ut0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 16:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267918AbUI1UtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 16:49:25 -0400
Received: from peabody.ximian.com ([130.57.169.10]:53680 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267904AbUI1Use
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 16:48:34 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Andrew Morton <akpm@osdl.org>, Ray Lee <ray-lk@madrabbit.org>,
       linux-kernel@vger.kernel.org, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <1096404035.30123.22.camel@vertex>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
	 <20040928120830.7c5c10be.akpm@osdl.org>  <1096404035.30123.22.camel@vertex>
Content-Type: text/plain
Date: Tue, 28 Sep 2004 16:47:13 -0400
Message-Id: <1096404433.4911.57.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 16:40 -0400, John McCutchan wrote:

> If the ioctl() based interface is so bad, we could change it to a
> write() based interface.

What baffles me is that a write() interface is infinitely more type
unsafe, arbitrary, and uncontrolled than an ioctl() one.

	Robert Love


