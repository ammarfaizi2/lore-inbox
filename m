Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVEKFdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVEKFdg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 01:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVEKFdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 01:33:36 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:13503 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261893AbVEKFdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 01:33:33 -0400
Date: Tue, 10 May 2005 22:33:21 -0700
From: Greg KH <gregkh@suse.de>
To: Per Liden <per@fukt.bth.se>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050511053320.GC8287@suse.de>
References: <20050506212227.GA24066@kroah.com> <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se> <20050509211323.GB5297@tsiryulnik> <Pine.LNX.4.63.0505102351300.8637@1-1-2-5a.f.sth.bostream.se> <20050510224112.GA4967@kroah.com> <Pine.LNX.4.63.0505110057550.20513@1-1-2-5a.f.sth.bostream.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0505110057550.20513@1-1-2-5a.f.sth.bostream.se>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 01:56:01AM +0200, Per Liden wrote:
> On Tue, 10 May 2005, Greg KH wrote:
> 
> > On Wed, May 11, 2005 at 12:17:12AM +0200, Per Liden wrote:
> > > I'd like to get a better understanding of that as well. Why invent a 
> > > second on demand module loader when we have kmod? The current approach 
> > > feels like a step back to something very similar to the old kerneld.
> > 
> > kmod is not used at all if you are running udev on your system.
> 
> Since when does udev load modules for you?

It does not.  That was my point :)

> And how would it know when to load "device less" modules such as
> filesystems?

Ah damm, I forgot about those pesky things.  Oh well, my plot to rid the
kernel of kmod will take a few more years...

greg k-h
