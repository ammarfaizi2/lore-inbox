Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265069AbUEMVVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbUEMVVe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 17:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbUEMVVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 17:21:34 -0400
Received: from CPE0000c02944d6-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.215]:5558
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S265069AbUEMVVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 17:21:32 -0400
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
From: John McCutchan <ttb@tentacle.dhs.org>
To: raven@themaw.net
Cc: linux-kernel@vger.kernel.org, nautilus-list@gnome.org
In-Reply-To: <Pine.LNX.4.58.0405132330480.13693@donald.themaw.net>
References: <1084152941.22837.21.camel@vertex>
	 <Pine.LNX.4.58.0405132330480.13693@donald.themaw.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1084483479.31578.2.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 13 May 2004 17:24:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-13 at 11:36, raven@themaw.net wrote:
> Hi John.
> 
> On Sun, 9 May 2004, John McCutchan wrote:
> 
> > Hi,
> > 
> > I have been working on inotify a dnotify replacement. 
> 
> I have a rather unusual requirement for notification events.
> 
> I've had a brief look at the code but it doesn't look like it would 
> cater for it.
> 
> Would this allow me to receive a notification when a directory is 
> passed over during a path walk?

You can easily add event types to inotify, and just hook in at the
proper point in the kernel to get the events sent. That being said, I
don't think this would be a worth while event to have.

John
