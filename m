Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbVLAV5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbVLAV5k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVLAV5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:57:40 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:45483 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932511AbVLAV5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:57:39 -0500
Date: Thu, 1 Dec 2005 16:57:30 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Greg KH <greg@kroah.com>
cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: mousedev auto load on 2.6.14-rc{2,3}
In-Reply-To: <20051201215017.GB22439@kroah.com>
Message-ID: <Pine.LNX.4.58.0512011656300.32670@gandalf.stny.rr.com>
References: <1133464818.7130.27.camel@localhost.localdomain>
 <20051201213431.GA22439@kroah.com> <Pine.LNX.4.58.0512011641360.32444@gandalf.stny.rr.com>
 <20051201215017.GB22439@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2005, Greg KH wrote:
>
> The input core changed the way it exports its information in sysfs.  Now
> it properly shows the heirachy of input devices (look at the difference
> in /sys/class/input in 2.6.14 and 2.6.15-rc2.)  A recent version of udev
> is required to be updated to handle this properly, but if you are on
> unstable, you should already have that change.
>
> Hope this helps explain things.
>

Yes it does, thanks!

I guess it's time to do another apt-get update ;-)

-- Steve

