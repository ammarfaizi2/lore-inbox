Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVDEWNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVDEWNz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 18:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVDEWNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 18:13:54 -0400
Received: from peabody.ximian.com ([130.57.169.10]:34273 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261829AbVDEWKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 18:10:03 -0400
Subject: Re: [patch] inotify for 2.6.11
From: Robert Love <rml@novell.com>
To: Prakash Punnoor <prakashp@arcor.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4252C8D8.9040109@arcor.de>
References: <1109961444.10313.13.camel@betsy.boston.ximian.com>
	 <4252453E.7060407@arcor.de> <1112717566.7324.19.camel@betsy>
	 <4252C8D8.9040109@arcor.de>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 18:09:48 -0400
Message-Id: <1112738988.7324.51.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 19:20 +0200, Prakash Punnoor wrote:

> BTW, what else could I use to make use of inotify? I know fam, which afaik
> only uses dnotify.

Here is a little sample glib application that shows the ease-yet-power
of inotify.

http://www.kernel.org/pub/linux/kernel/people/rml/inotify/glib/

It integrates inotify watches into the glib mainloop via GIOChannel.
Everything is abstracted behind simple interfaces, so this might prove a
nice start for curious inotify developers.

	Robert Love


