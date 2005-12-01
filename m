Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbVLAVq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVLAVq3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVLAVq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:46:29 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:31151 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932493AbVLAVq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:46:28 -0500
Date: Thu, 1 Dec 2005 16:46:14 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Greg KH <greg@kroah.com>
cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: mousedev auto load on 2.6.14-rc{2,3}
In-Reply-To: <20051201213431.GA22439@kroah.com>
Message-ID: <Pine.LNX.4.58.0512011641360.32444@gandalf.stny.rr.com>
References: <1133464818.7130.27.camel@localhost.localdomain>
 <20051201213431.GA22439@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2005, Greg KH wrote:

> On Thu, Dec 01, 2005 at 02:20:18PM -0500, Steven Rostedt wrote:
> > Hi,
> >
> > Using the same config between 2.6.14 and 2.6.15-rc2 (and with rc3,
> > haven't tried rc4). The mousedev gets auto loaded on 2.6.14 but does not
> > with 2.6.15-rc{2,3}.  Did something change to prevent the auto loading
> > of mousedev?
>
> This needs to be a FAQ somewhere.  This is a known bug in Debian's
> hotplug/udev package that is being worked on.
>
> It's not a kernel bug, but a userspace one.  Other distros do not have
> this issue, perhaps I could recommend a different one for you?  :)
>

Actually, I never said it was a kernel bug :)

I was just wondering what changed between 2.6.14 and 2.6.15-rc2 to break
debian's hotplug/udev packages.

As for another distro? Hmm. I started with Slackware, switched to RedHat
because of the RPMs, toyed with Gentoo (too much work), toyed with SuSE
(too commercial), then left RedHat (because of RPMs!) and have loved
debian since (too much work only when I do too much, like updating a lot
in the unstable release ;)

-- Steve

