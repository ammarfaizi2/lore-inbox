Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267344AbUH1Rho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267344AbUH1Rho (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 13:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267351AbUH1Rho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 13:37:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:5524 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267344AbUH1Rha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 13:37:30 -0400
Date: Sat, 28 Aug 2004 10:26:20 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: adam@yggdrasil.com, steve@steve-parker.org, linux-kernel@vger.kernel.org
Subject: Re: PWC issue
Message-Id: <20040828102620.25a934a2.rddunlap@osdl.org>
In-Reply-To: <20040828161242.GA14308@kroah.com>
References: <200408281750.i7SHo5C05936@freya.yggdrasil.com>
	<20040828051919.GC10151@kroah.com>
	<20040828081100.6b6c9f8c.rddunlap@osdl.org>
	<20040828161242.GA14308@kroah.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2004 09:12:42 -0700 Greg KH wrote:

| On Sat, Aug 28, 2004 at 08:11:00AM -0700, Randy.Dunlap wrote:
| > On Fri, 27 Aug 2004 22:19:19 -0700 Greg KH wrote:
| > 
| > | On Sat, Aug 28, 2004 at 10:50:05AM -0700, Adam J. Richter wrote:
| > | > 
| > | > 	By the way, I have a long running dispute with Greg K-H
| > | > about his refusal so far to remove replace the GPL incompatible
| > | > firmware in certain USB serial drivers with such a user level
| > | > loading mechanism.  Go figure.
| > | 
| > | Send me a patch to do so, and I will apply it (must include userspace
| > | files so that hotplug can load them properly.)
| > | 
| > | The last time we went around about this I rejected it as we were in a
| > | stable kernel series.  As that is now not true, I'm open to the patch.
| > 
| > Which part is now not true?
| 
| The "stable" part.

I guess I'm still confused by some of what I consider contradictory
remarks by Linus at the kernel summit, and the lack of a summary of
that particular kernel summit session (other than on lwn.net).

I think that we have only a stable kernel and not a development
kernel series now, and that's a loss.  But it's a loss either way
that we toss & turn it...

| Actually in thinking about it some more, we should offer up both options
| for at least 6 months, with a warning that the in-kernel stuff is going
| to be deleted on a specific date.  That gives everyone time to convert
| their userspace utilities to use the new firmware download code.
| 
| Sound good?

Some bounded time would be good, yes.  Would have been good for pwc also,
although Nemosoft has had 4 years to move the kernel decompression to
userspace afaik, so it seems that he has taken way too long to get
that done.

--
~Randy
