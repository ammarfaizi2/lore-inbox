Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbWF0TDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbWF0TDf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbWF0TDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:03:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44931 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932522AbWF0TDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:03:34 -0400
Date: Tue, 27 Jun 2006 21:03:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Brad Campbell <brad@wasp.net.au>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       suspend2-devel@lists.suspend2.net
Subject: Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion in	-mm
Message-ID: <20060627190323.GA28863@elf.ucw.cz>
References: <200606270147.16501.ncunningham@linuxmail.org> <20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A14D3D.8060003@wasp.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-06-27 19:22:37, Brad Campbell wrote:
> Pavel Machek wrote:
> >>Some of the advantages of suspend2 over swsusp and uswsusp are:
> >>
> >>- Speed (Asynchronous I/O and readahead for synchronous I/O)
> >
> >uswsusp should be able to match suspend2's speed. It can do async I/O,
> >etc...
> 
> ARGH!
> 
> And the next version of windows will have all the wonderful features that 
> MacOSX has now so best not upgrade to Mac as you can just wait for the next 
> version of windows.
> 
> suspend2 has it *now*. It works, it's stable.

uswsusp also has it *now*, in case you missed it. I just do not do
benchmark runs all the time, and don't know how fast suspend2
is. uswsusp already uses normal I/O ... and that is asynchronous.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
