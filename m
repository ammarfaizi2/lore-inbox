Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbUKFA5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbUKFA5G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 19:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbUKFA5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 19:57:06 -0500
Received: from peabody.ximian.com ([130.57.169.10]:51399 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261292AbUKFA5E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 19:57:04 -0500
Subject: Re: [patch] inotify: add FIONREAD support
From: Robert Love <rml@novell.com>
To: Greg KH <greg@kroah.com>
Cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20041106004755.GA23981@kroah.com>
References: <1099696444.6034.266.camel@localhost>
	 <20041106004755.GA23981@kroah.com>
Content-Type: text/plain
Date: Fri, 05 Nov 2004 19:57:43 -0500
Message-Id: <1099702663.6034.270.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-05 at 16:47 -0800, Greg KH wrote:

> But sparse will spit out warnings with code like this :(

Why?  p is annotated __user.

> Actually, the whole inotify patch probably isn't sparse clean...

Probably not (I don't run sparse myself) but I did try to annotate all
the user pointers with __user.

If you--or anyone else who uses sparse--sends me any warnings, I'll fix
them.

	Robert Love


