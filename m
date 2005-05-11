Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVEKRjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVEKRjP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 13:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVEKRjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 13:39:15 -0400
Received: from 1-1-2-5a.f.sth.bostream.se ([81.26.255.57]:34715 "EHLO
	1-1-2-5a.f.sth.bostream.se") by vger.kernel.org with ESMTP
	id S262000AbVEKRhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 13:37:00 -0400
Date: Wed, 11 May 2005 19:36:54 +0200 (CEST)
From: Per Liden <per@fukt.bth.se>
X-X-Sender: per@1-1-2-5a.f.sth.bostream.se
To: Greg KH <gregkh@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
In-Reply-To: <20050511053320.GC8287@suse.de>
Message-ID: <Pine.LNX.4.63.0505111824060.2216@1-1-2-5a.f.sth.bostream.se>
References: <20050506212227.GA24066@kroah.com>
 <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se>
 <20050509211323.GB5297@tsiryulnik> <Pine.LNX.4.63.0505102351300.8637@1-1-2-5a.f.sth.bostream.se>
 <20050510224112.GA4967@kroah.com> <Pine.LNX.4.63.0505110057550.20513@1-1-2-5a.f.sth.bostream.se>
 <20050511053320.GC8287@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2005, Greg KH wrote:

> On Wed, May 11, 2005 at 01:56:01AM +0200, Per Liden wrote:
> > On Tue, 10 May 2005, Greg KH wrote:
> > 
> > > On Wed, May 11, 2005 at 12:17:12AM +0200, Per Liden wrote:
> > > > I'd like to get a better understanding of that as well. Why invent a 
> > > > second on demand module loader when we have kmod? The current approach 
> > > > feels like a step back to something very similar to the old kerneld.
> > > 
> > > kmod is not used at all if you are running udev on your system.
> > 
> > Since when does udev load modules for you?
> 
> It does not.  That was my point :)

Sorry, but I still don't get your point. Whether kmod is used or not is 
unrelated to the use of udev.

> > And how would it know when to load "device less" modules such as
> > filesystems?
> 
> Ah damm, I forgot about those pesky things.  Oh well, my plot to rid the
> kernel of kmod will take a few more years...

I'm relieved ;)

/Per
