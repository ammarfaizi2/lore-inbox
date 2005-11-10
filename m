Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVKJUyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVKJUyI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 15:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVKJUyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 15:54:08 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:32798 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932114AbVKJUyH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 15:54:07 -0500
Date: Thu, 10 Nov 2005 21:52:35 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, than@redhat.com, linux-kernel@vger.kernel.org,
       Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [PATCH] kbuild updates
Message-ID: <20051110205235.GA7584@mars.ravnborg.org>
References: <20051106101844.GA11921@mars.ravnborg.org> <Pine.LNX.4.61.0511061341290.12843@scrub.home> <20051106132111.GA9042@mars.ravnborg.org> <Pine.LNX.4.61.0511071102380.12843@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511071102380.12843@scrub.home>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 11:13:16AM +0100, Roman Zippel wrote:
> Hi,
> 
> On Sun, 6 Nov 2005, Sam Ravnborg wrote:
> 
> > On Sun, Nov 06, 2005 at 01:44:32PM +0100, Roman Zippel wrote:
> > > 
> > > What exactly is the problem? How does Fedora use QTLIB?
> > 
> > See:
> >  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=137926
> 
> I'm not really happy with this patch. I don't really like relying on 
> QTLIB, it's a really ugly hack.
> If the nonextisting ../lib64 dir is the problem, I'd more prefer a patch 
> like this:
Hi Roman.

Than confirmed in private mail that this fixes the problem he saw.
Can you either send me a properly Signed-off-by: patch or send the patch
to Linus yourself.

[I got Than' mailaddress wrong in my initial mial ::-(]

thanks,

	Sam
