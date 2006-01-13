Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161599AbWAMAVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161599AbWAMAVx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 19:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161597AbWAMAVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 19:21:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29347 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161599AbWAMAVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 19:21:53 -0500
Date: Fri, 13 Jan 2006 01:21:38 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Place for userland swsusp parts
Message-ID: <20060113002138.GE10088@elf.ucw.cz>
References: <20060111221511.GA8223@elf.ucw.cz> <200601120819.42512.ncunningham@linuxmail.org> <20060112143851.GB9752@elf.ucw.cz> <200601122113.24461.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601122113.24461.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > On Thursday 12 January 2006 08:15, Pavel Machek wrote:
> > > > Is there some place where we could  put userland swsusp parts under
> > > > version control?
> > > >
> > > > swsusp.sf.net looks like possible place, but it has been in use by
> > > > suspend2... Is it still being used? If not, would it be possible to
> > > > "hijack" it for swsusp development?
> > > 
> > > It's not still being used (we have suspend2.net now). The only problem I see 
> > > with that is that it still has all the old suspend2 stuff and Sourceforge 
> > > make it really hard to clear out a project's files. You were talking about 
> > > calling it uswsusp or something like that. How about starting a 
> > > uswsusp.sf.net?
> > 
> > Rafael, do you have repository to place userland parts in, or should I
> > start uswsusp.sf.net project, or do you want to do it?
> 
> I think I can host them (the box is moving tomorrow, hopefully, so it should get
> enough bandwidth ;-)), but I'm afraid I won't have time to set up a mailing list
> etc.

Actually, it would probably be better to put it on sourceforge or
something like that. That way you don't have to care about sysadmin
stuff (mailing lists etc), backups, backup conectivity, etc, etc.

> IMHO uswsusp.sf.net would be too similar to swsusp.sf.net, especially that
> swsusp.sf.net is redirected to www.suspend2.net.

Or maybe we can get hosting on suspend2.net? Or create
userswsusp.sf.net (that name is ugly :-().

...some revision control would be nice, but perhaps revision control
is enough and we can just put git tree on kernel.org?

								Pavel
-- 
Thanks, Sharp!
