Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965281AbVKGWuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965281AbVKGWuP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 17:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbVKGWuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 17:50:15 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:3161 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S965212AbVKGWuN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 17:50:13 -0500
Date: Mon, 7 Nov 2005 23:50:24 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Zachary Amsden <zach@vmware.com>, Russell King <rmk@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davej@redhat.com, than@redhat.com
Subject: Re: [PATCH 1/1] My tools break here
Message-ID: <20051107225024.GB10492@mars.ravnborg.org>
References: <200511072156.jA7LuQKv009711@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511072156.jA7LuQKv009711@zach-dev.vmware.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 01:56:26PM -0800, Zachary Amsden wrote:
> I have to revert the recent addition of -imacros to the Makefile to get my
> tool chain to build.  Without the change, below, I get:
> 
> Note that this looks entirely like a toolchain bug.
Then fix your toolchain instead of reverting the -imacros patch.

The change has been in -git for a full day and in latest -mm too.
And so far this is the only report that it breaks - I no one else
complains it will stay.

	Sam
