Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVDERxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVDERxv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 13:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVDERuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 13:50:23 -0400
Received: from peabody.ximian.com ([130.57.169.10]:19935 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261860AbVDERfx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 13:35:53 -0400
Subject: Re: [patch] inotify for 2.6.11
From: Robert Love <rml@novell.com>
To: Prakash Punnoor <prakashp@arcor.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4252C8D8.9040109@arcor.de>
References: <1109961444.10313.13.camel@betsy.boston.ximian.com>
	 <4252453E.7060407@arcor.de> <1112717566.7324.19.camel@betsy>
	 <4252C8D8.9040109@arcor.de>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 13:35:38 -0400
Message-Id: <1112722538.7324.39.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 19:20 +0200, Prakash Punnoor wrote:

> BTW, what else could I use to make use of inotify? I know fam, which afaik
> only uses dnotify.

Beagle, a desktop search infrastructure.  Check out
http://www.gnome.org/projects/beagle

Some other little projects.  If anyone else is using it, please let us
know!

The main problem is that dnotify sucks so bad now that no one uses it.
So we don't have any existing applications to convert, besides FAM, and
we did that (via Gamin).

I've been meaning to write some sample GNOME code to show how easy it is
to use Inotify, even directly.  I'll get on that.

> > Anyhow, this should fix it.  Confirm?
> 
> So far no problems. Interesting enough the previous patch worked w/o problem
> the last hours...

It might of been caused by a bug in Gamin, so it took some while to
expose.  It should only happen when the user asks to remove a watch on a
wd that does not exist (I just forgot to check that error case in a bug
fix I added).

Keep pounding.  It ought to be fixed, but please let me know if not!

	Robert Love



