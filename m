Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbUBXRwL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbUBXRwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:52:08 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:59294 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262344AbUBXRvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:51:52 -0500
Subject: Re: Intel vs AMD x86-64
From: Albert Cahalan <albert@users.sf.net>
To: Dave Jones <davej@redhat.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20040224173444.GL11203@redhat.com>
References: <1077590524.8084.237.camel@cube>
	 <20040224164404.GB10157@redhat.com> <1077635481.8120.300.camel@cube>
	 <20040224173444.GL11203@redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1077636547.8084.303.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Feb 2004 10:29:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-24 at 12:34, Dave Jones wrote:
> On Tue, Feb 24, 2004 at 10:11:22AM -0500, Albert Cahalan wrote:
> 
>  > > so this isn't possible.  The amd64 GART driver goes to great
>  > > lengths to make sure it does update the northbridges on every
>  > > CPU whenever something changes.
>  > 
>  > Of course. That's the easy way; you won't need
>  > to worry about memory interleave or out-of-bounds
>  > prefetch if you keep everything coherent.
>  > 
>  > I'm just saying it would be neat, and potentially
>  > useful, to intentionally violate this. Of greatest
>  > interest would be the 2-way Opteron boards that
>  > only have RAM connected to the CPU closest to PCI.
>  > The sidecar CPU :-) could be ignored.
> 
> Why on earth would you want to do that ?
> It wouldn't buy you anything at all other than a world of pain.

faster IO-MMU operations


