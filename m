Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVKJUx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVKJUx2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 15:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVKJUx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 15:53:28 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:53771 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932109AbVKJUx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 15:53:28 -0500
Date: Thu, 10 Nov 2005 21:54:23 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: zach@vmware.com, rmk@arm.linux.org.uk, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, davej@redhat.com, than@redhat.com
Subject: Re: [PATCH 1/1] My tools break here
Message-ID: <20051110205423.GB7584@mars.ravnborg.org>
References: <200511072156.jA7LuQKv009711@zach-dev.vmware.com> <20051107225024.GB10492@mars.ravnborg.org> <20051107150807.5f85ec13.akpm@osdl.org> <20051110021255.3cf79cee.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110021255.3cf79cee.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 02:12:55AM -0800, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > > The change has been in -git for a full day and in latest -mm too.
> >  > And so far this is the only report that it breaks - I no one else
> >  > complains it will stay.
> > 
> >  Let's wait and see how many more people are affected.
> 
> duh.  The next bunny is me.
> 
> /usr/local/gcc-3.2.1/lib/gcc-lib/i686-pc-linux-gnu/3.2.1/tradcpp0: output filename specified twice
> 
> That's a vanilla gcc-3.2.1
And Zachary's gcc was a redhat 9.0 native compiler.

> 
> Is there any downside to using -include?
> 
-imacros was simpler according to info gcc.
I've applied Zachary's patch and will push to kernel.org later tonight.

	Sam
