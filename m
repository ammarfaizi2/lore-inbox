Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267397AbUH1QUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267397AbUH1QUk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 12:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267381AbUH1QOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 12:14:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:9165 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267401AbUH1QNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 12:13:31 -0400
Date: Sat, 28 Aug 2004 09:12:42 -0700
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: adam@yggdrasil.com, steve@steve-parker.org, linux-kernel@vger.kernel.org
Subject: Re: PWC issue
Message-ID: <20040828161242.GA14308@kroah.com>
References: <200408281750.i7SHo5C05936@freya.yggdrasil.com> <20040828051919.GC10151@kroah.com> <20040828081100.6b6c9f8c.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828081100.6b6c9f8c.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 08:11:00AM -0700, Randy.Dunlap wrote:
> On Fri, 27 Aug 2004 22:19:19 -0700 Greg KH wrote:
> 
> | On Sat, Aug 28, 2004 at 10:50:05AM -0700, Adam J. Richter wrote:
> | > 
> | > 	By the way, I have a long running dispute with Greg K-H
> | > about his refusal so far to remove replace the GPL incompatible
> | > firmware in certain USB serial drivers with such a user level
> | > loading mechanism.  Go figure.
> | 
> | Send me a patch to do so, and I will apply it (must include userspace
> | files so that hotplug can load them properly.)
> | 
> | The last time we went around about this I rejected it as we were in a
> | stable kernel series.  As that is now not true, I'm open to the patch.
> 
> Which part is now not true?

The "stable" part.

Actually in thinking about it some more, we should offer up both options
for at least 6 months, with a warning that the in-kernel stuff is going
to be deleted on a specific date.  That gives everyone time to convert
their userspace utilities to use the new firmware download code.

Sound good?

thanks,

greg k-h
