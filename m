Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263594AbTEYRRJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 13:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbTEYRRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 13:17:09 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:2458 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263594AbTEYRRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 13:17:08 -0400
Date: Sun, 25 May 2003 12:40:57 -0400
From: Ben Collins <bcollins@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Adam Sampson <azz@us-lot.org>, Patrick Mochel <mochel@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
Message-ID: <20030525164057.GA439@phunnypharm.org>
References: <y2awugf2pz9.fsf@cartman.at.fivegeeks.net> <Pine.LNX.4.44.0305251008490.21192-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305251008490.21192-100000@home.transmeta.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 10:10:56AM -0700, Linus Torvalds wrote:
> 
> On 25 May 2003, Adam Sampson wrote:
> > 
> > If you're going to do this, it might make sense to call it "strlcpy"
> > for consistency with the OpenBSD-introduced function of the same name
> > that's getting included in a lot of userspace these days...
> 
> Sure, done. I'll check it in asap (and I'll make the devfs parts that Ben 
> was unhappy about use it too).
> 
> Somebody (else ;) should probably go through our current uses of strncpy()  
> and see if they make sense. Some of them probably do, but I suspect 
> anything name/path related does not.

Please hold off. I have a better patch that includes strlcat. Actually
tested.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
