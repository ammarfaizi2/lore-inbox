Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVCFAhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVCFAhj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 19:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVCFAhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 19:37:36 -0500
Received: from peabody.ximian.com ([130.57.169.10]:55433 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261256AbVCFAha
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 19:37:30 -0500
Subject: Re: [patch] inotify for 2.6.11
From: Robert Love <rml@novell.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John McCutchan <ttb@tentacle.dhs.org>, torvalds@osdl.org
In-Reply-To: <20050306000409.GD31261@infradead.org>
References: <1109961444.10313.13.camel@betsy.boston.ximian.com>
	 <20050306000409.GD31261@infradead.org>
Content-Type: text/plain
Date: Sat, 05 Mar 2005 19:40:06 -0500
Message-Id: <1110069606.12936.42.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-06 at 00:04 +0000, Christoph Hellwig wrote:

> The user interface is still bogus.

I presume you are talking about the ioctl.  I have tried to engage you
and others on what exactly you prefer instead.  I have said that moving
to a write interface is fine but I don't see how ut is _any_ better than
the ioctl.  Write is less typed, in fact, since we lose the command
versus argument delineation.

But if it is a anonymous decision, I'll switch it.  Or take patches. ;-)
It isn't a big deal.

> Also now version of it has stayed in -mm long enough because bad
> bugs pop up almost weekly.

I don't follow this sentence.

Best,

	Robert Love


