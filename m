Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268049AbUI1VxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268049AbUI1VxU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 17:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268054AbUI1VxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 17:53:06 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:39117 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S268049AbUI1Vuf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 17:50:35 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Ray Lee <ray-lk@madrabbit.org>
To: Robert Love <rml@novell.com>
Cc: John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <1096404433.4911.57.camel@betsy.boston.ximian.com>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
	 <20040928120830.7c5c10be.akpm@osdl.org>  <1096404035.30123.22.camel@vertex>
	 <1096404433.4911.57.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Organization: http://madrabbit.org/
Date: Tue, 28 Sep 2004 14:39:13 -0700
Message-Id: <1096407553.5177.41.camel@issola.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 16:47 -0400, Robert Love wrote:
> On Tue, 2004-09-28 at 16:40 -0400, John McCutchan wrote:
> 
> > If the ioctl() based interface is so bad, we could change it to a
> > write() based interface.
> 
> What baffles me is that a write() interface is infinitely more type
> unsafe, arbitrary, and uncontrolled than an ioctl() one.

The word "Huh?" comes to mind, for some reason.

It's just as easy to pass crap via ioctl() as write(). Regardless, I'm
not the Arbiter Of Taste on this topic. I'm merely following what I
believe to be the prevailing (<cough>Linus</cough>) sentiments are
regarding ioctl()s.

Well, that, and I personally find write(fd, &x, sizeof x) a cleaner
interface. My personal preference is of little importance on this topic,
however.

Ray

