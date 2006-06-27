Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422674AbWF0WYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422674AbWF0WYJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422664AbWF0WYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:24:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59092 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1422671AbWF0WYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:24:05 -0400
Date: Wed, 28 Jun 2006 00:23:51 +0200
From: Pavel Machek <pavel@suse.cz>
To: Avuton Olrich <avuton@gmail.com>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Brad Campbell <brad@wasp.net.au>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       suspend2-devel@lists.suspend2.net
Subject: Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion in -mm
Message-ID: <20060627222351.GQ29199@elf.ucw.cz>
References: <200606270147.16501.ncunningham@linuxmail.org> <20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au> <20060627154130.GA31351@rhlx01.fht-esslingen.de> <3aa654a40606270901k4af63de8oe9aa7dde2a2d6a22@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa654a40606270901k4af63de8oe9aa7dde2a2d6a22@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-06-27 09:01:33, Avuton Olrich wrote:
> On 6/27/06, Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> >Hi,
> >
> >On Tue, Jun 27, 2006 at 07:22:37PM +0400, Brad Campbell wrote:
> >> Pavel Machek wrote:
> >> >>Some of the advantages of suspend2 over swsusp and uswsusp are:
> >> >>
> >> >>- Speed (Asynchronous I/O and readahead for synchronous I/O)
> >> >
> >> >uswsusp should be able to match suspend2's speed. It can do async I/O,
> >> >etc...
> >>
> >> ARGH!
> >>
> >> And the next version of windows will have all the wonderful features that
> >> MacOSX has now so best not upgrade to Mac as you can just wait for the
> >> next version of windows.
> >>
> >> suspend2 has it *now*. It works, it's stable.
> 
> I'm not sure it's a reason for it to go in, but the truth is suspend2
> does work in more cases, ime. uswsusp is alpha(?) swsusp doesn't work
> (for me in most cases), suspend-to-ram doesn't work (probably even
> less cases than swsusp), suspend2 works. It's working status for more
> of the userbase should (hopefully) be a concideration.

When swsusp does not work, there's no point trying uswsusp. It is
mostly same code.

suspend-to-ram is a very different animal.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
