Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUDCIXS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 03:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUDCIXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 03:23:18 -0500
Received: from gprs214-57.eurotel.cz ([160.218.214.57]:38528 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261628AbUDCIXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 03:23:17 -0500
Date: Sat, 3 Apr 2004 10:23:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040403082303.GA1316@elf.ucw.cz>
References: <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz> <406DE280.6050109@nortelnetworks.com> <20040403004947.GI653@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040403004947.GI653@mail.shareable.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Could you not change it back to a normal inode when refcount becomes 1? 
> 
> You can only do that if the cowid object has a pointer to the last
> remaining reference to it.  That's possible, but more complicated and
> would incur a little more I/O per cow operation.

You'd have to have pointers to all references to it... because you
can't tell in advance which one will be the last to go away.

But I agree its not a big problem.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
