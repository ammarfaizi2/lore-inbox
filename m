Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUJAQFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUJAQFf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 12:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUJAQFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 12:05:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:30363 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263736AbUJAQFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 12:05:15 -0400
Date: Fri, 1 Oct 2004 08:58:23 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Robert Love <rml@novell.com>
Cc: mpm@selenic.com, ttb@tentacle.dhs.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, gamin-list@gnome.org
Subject: Re: [patch] make dnotify compile-time configurable
Message-Id: <20041001085823.05adc9b5.rddunlap@osdl.org>
In-Reply-To: <1096645479.7676.15.camel@betsy.boston.ximian.com>
References: <1096611874.4803.18.camel@localhost>
	<20041001151124.GQ31237@waste.org>
	<1096644076.7676.6.camel@betsy.boston.ximian.com>
	<20041001083110.76a58fd2.rddunlap@osdl.org>
	<1096645479.7676.15.camel@betsy.boston.ximian.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Oct 2004 11:44:39 -0400 Robert Love wrote:

| On Fri, 2004-10-01 at 08:31 -0700, Randy.Dunlap wrote:
| 
| > I'd rather see inotify additions and dnotify config options kept
| > separate.  They may serve a similar purpose, but inotify doesn't
| > replace the dnotify API.  If the latter were true, combining
| > them would make sense IMO.
| 
| I'm not really following.
| 
| Whether or not dnotify is a configuration option is separate, and could
| go into the kernel either way.

Sorry, that's about all that I was trying to say.  If patches A & B
are logically separate, don't combine them.  Nothing new there.

| But what matters if our inotify patch also carries the change?  People
| with inotify definitely DO want this patch, because they don't need
| dnotify.  Not much uses dnotify--it is a pain to use--and inotify
| replaces its functionality.

Well, the patch shouldn't remove dnotify unconditionally, or not
until we have that elusive stable kernel series that people keep
mentioning elsewhere.

| It is also a practical move: the diffs conflict.

I see.

-- 
~Randy
MOTD:  Always include version info.
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
