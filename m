Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269837AbUIDIhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269837AbUIDIhu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 04:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269839AbUIDIhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 04:37:50 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:14746 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S269837AbUIDIhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 04:37:48 -0400
Date: Sat, 4 Sep 2004 09:37:47 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Alex Deucher <alexdeucher@gmail.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
In-Reply-To: <41397C08.1020507@tungstengraphics.com>
Message-ID: <Pine.LNX.4.58.0409040933270.25475@skynet>
References: <Pine.LNX.4.58.0409040107190.18417@skynet> 
 <a728f9f904090317547ca21c15@mail.gmail.com>  <Pine.LNX.4.58.0409040158400.25475@skynet>
  <9e4733910409032051717b28c0@mail.gmail.com>  <Pine.LNX.4.58.0409040548490.25475@skynet>
 <9e47339104090323047b75dbb2@mail.gmail.com> <41397086.3020509@tungstengraphics.com>
 <Pine.LNX.4.58.0409040852090.25475@skynet> <41397C08.1020507@tungstengraphics.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Let me be clear that I am unwilling to support changes to the DRM that break
> it's usability on other operating systems on principle.

I'm in agreement on that, ...
>
> Maybe it's time to consider a fork of the DRM to allow a major experimentation
> of the form Jon envisages to proceed without worrying about boring constraints
> like keeping BSD working, backwards compatibility, etc.  And the current DRM
> architecture, which is pretty much stabilized, can continue to do those boring
> tasks, and accumulate new drivers, until GNULonghorn is finished...

I think it might be an idea myself, but not at this stage, I think a month
or two from now it might be a better time, if we get an agreeable
re-design done, then I'd be willing to let a fork proceed from that point,
so that at least the DRMs are all coming from the same point,

I think we should hold off on putting 2d stuff into the 3d drivers until
the DRM is rearchitected into a nice clean stable system that is actually
liked by kernel developers :-), I'm pushing the second set of macros
removals to Linus over the next week, along with experimenting on a
core/library tree...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

