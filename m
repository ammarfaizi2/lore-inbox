Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264311AbUENByd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbUENByd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 21:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUENByd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 21:54:33 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:32527 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264311AbUENByb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 21:54:31 -0400
Date: Fri, 14 May 2004 10:02:56 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: John McCutchan <ttb@tentacle.dhs.org>
cc: linux-kernel@vger.kernel.org, nautilus-list@gnome.org
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
In-Reply-To: <1084483479.31578.2.camel@vertex>
Message-ID: <Pine.LNX.4.58.0405140959150.29527@wombat.indigo.net.au>
References: <1084152941.22837.21.camel@vertex>  <Pine.LNX.4.58.0405132330480.13693@donald.themaw.net>
 <1084483479.31578.2.camel@vertex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2004, John McCutchan wrote:

> On Thu, 2004-05-13 at 11:36, raven@themaw.net wrote:
> > Hi John.
> > 
> > On Sun, 9 May 2004, John McCutchan wrote:
> > 
> > > Hi,
> > > 
> > > I have been working on inotify a dnotify replacement. 
> > 
> > I have a rather unusual requirement for notification events.
> > 
> > I've had a brief look at the code but it doesn't look like it would 
> > cater for it.
> > 
> > Would this allow me to receive a notification when a directory is 
> > passed over during a path walk?
> 
> You can easily add event types to inotify, and just hook in at the
> proper point in the kernel to get the events sent. That being said, I
> don't think this would be a worth while event to have.
> 

But you don't know what I need it for. 

Maybe it is a bit of sledge hammer.

Hopefully I'll have some time to check it out further on the weekend.

Ian

