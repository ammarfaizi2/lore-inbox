Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268752AbUHYVPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268752AbUHYVPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 17:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268738AbUHYVAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 17:00:42 -0400
Received: from [66.35.79.110] ([66.35.79.110]:7126 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S268701AbUHYU4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:56:35 -0400
Date: Wed, 25 Aug 2004 13:56:18 -0700
From: Tim Hockin <thockin@hockin.org>
To: Rik van Riel <riel@redhat.com>
Cc: Hans Reiser <reiser@namesys.com>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>, michael.waychison@sun.com
Subject: Re: Using fs views to isolate untrusted processes: I need an assistant architect in the USA for Phase I of a DARPA funded linux kernel project
Message-ID: <20040825205618.GA7992@hockin.org>
References: <410D96DC.1060405@namesys.com> <Pine.LNX.4.44.0408251624540.5145-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408251624540.5145-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 04:25:24PM -0400, Rik van Riel wrote:
> > You can think of this as chroot on steroids.
> 
> Sounds like what you want is pretty much the namespace stuff
> that has been in the kernel since the early 2.4 days.
> 
> No need to replicate VFS functionality inside the filesystem.

When I was at Sun, we talked a lot about this.  Mike, does Sun have any
iterest in this?

We found a lot of shortcomings in implementing various namespace-ish
things.

