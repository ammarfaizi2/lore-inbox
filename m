Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266243AbUI0QZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUI0QZc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 12:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266249AbUI0QZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 12:25:32 -0400
Received: from peabody.ximian.com ([130.57.169.10]:13989 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266243AbUI0QZa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 12:25:30 -0400
Subject: Re: [gamin] [RFC][PATCH] inotify 0.10.0 [u]
From: Robert Love <rml@ximian.com>
To: azarah@nosferatu.za.org
Cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       Andrew Morton <akpm@osdl.org>, iggy@gentoo.org
In-Reply-To: <1096302060.11535.54.camel@nosferatu.lan>
References: <1096250524.18505.2.camel@vertex>
	 <1096302060.11535.54.camel@nosferatu.lan>
Content-Type: text/plain
Date: Mon, 27 Sep 2004 12:24:08 -0400
Message-Id: <1096302248.30503.21.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 18:21 +0200, Martin Schlemmer [c] wrote:

> I have just looked quickly at the inotify backend this weekend, so not
> really clued up yet, so excuse the stupid question:  Does this mean
> inotify is now up to par with dnotify/poll feature wise?  Or should we
> still look at getting inotify backend to use poll?

inotify supports poll in the sense that you can poll() or select()
on /dev/inotify.

dnotify does not support poll() at all (it is signal based), so your
question is kind of confusing.

I cannot think of any features that dnotify has that inotify does not.

	Robert Love


