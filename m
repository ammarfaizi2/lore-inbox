Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264495AbUEOEw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbUEOEw7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 00:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbUEOEw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 00:52:59 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:31750 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264495AbUEOEw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 00:52:57 -0400
Date: Sat, 15 May 2004 12:52:08 +0800 (WST)
From: raven@themaw.net
To: John McCutchan <ttb@tentacle.dhs.org>
cc: linux-kernel@vger.kernel.org, nautilus-list@gnome.org
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
In-Reply-To: <1084152941.22837.21.camel@vertex>
Message-ID: <Pine.LNX.4.58.0405151235370.1575@donald.themaw.net>
References: <1084152941.22837.21.camel@vertex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 May 2004, John McCutchan wrote:

> Hi,
> 
> I have been working on inotify a dnotify replacement. 

Help me here a little John I'm a little slow on the uptake.

> 
> inotify is a char device that has two ioctls: INOTIFY_WATCH and
> INOTIFY_IGNORE Which expect an inode number and an inode device number.
> I know that on some file systems the inode number and inode device
> number are not guaranteed to be unique. This driver is only meant for
> file systems that have unique inode numbers. 
> 
> The two biggest complaints people have about dnotify are
> 
> 1) dnotify delivers events using signals. 
> 
> 2) dnotify needs a file to be kept open on the device, causing problems
> during unmount. 

So we are saying we open the device file to do our stuff instead of 
keeping a file open?

In kernel functionality could be provided by calling appropriately exported 
routines?

This implementation caters read/write notifications only at this stage?

Ian
 

