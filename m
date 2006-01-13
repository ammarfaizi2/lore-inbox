Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbWAML0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWAML0P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 06:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWAML0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 06:26:15 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:38843 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S964961AbWAML0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 06:26:14 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Place for userland swsusp parts
Date: Fri, 13 Jan 2006 12:25:51 +0100
User-Agent: KMail/1.9
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       kernel list <linux-kernel@vger.kernel.org>
References: <20060111221511.GA8223@elf.ucw.cz> <200601122113.24461.rjw@sisk.pl> <20060113002138.GE10088@elf.ucw.cz>
In-Reply-To: <20060113002138.GE10088@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601131225.51635.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 13 January 2006 01:21, Pavel Machek wrote:
> > > > On Thursday 12 January 2006 08:15, Pavel Machek wrote:
> > > > > Is there some place where we could  put userland swsusp parts under
> > > > > version control?
> > > > >
> > > > > swsusp.sf.net looks like possible place, but it has been in use by
> > > > > suspend2... Is it still being used? If not, would it be possible to
> > > > > "hijack" it for swsusp development?
> > > > 
> > > > It's not still being used (we have suspend2.net now). The only problem I see 
> > > > with that is that it still has all the old suspend2 stuff and Sourceforge 
> > > > make it really hard to clear out a project's files. You were talking about 
> > > > calling it uswsusp or something like that. How about starting a 
> > > > uswsusp.sf.net?
> > > 
> > > Rafael, do you have repository to place userland parts in, or should I
> > > start uswsusp.sf.net project, or do you want to do it?
> > 
> > I think I can host them (the box is moving tomorrow, hopefully, so it should get
> > enough bandwidth ;-)), but I'm afraid I won't have time to set up a mailing list
> > etc.
> 
> Actually, it would probably be better to put it on sourceforge or
> something like that. That way you don't have to care about sysadmin
> stuff (mailing lists etc), backups, backup conectivity, etc, etc.

Agreed.

> > IMHO uswsusp.sf.net would be too similar to swsusp.sf.net, especially that
> > swsusp.sf.net is redirected to www.suspend2.net.
> 
> Or maybe we can get hosting on suspend2.net? Or create
> userswsusp.sf.net (that name is ugly :-().

suspend.sf.net seems to be available.  We can use it, I think.

> ...some revision control would be nice, but perhaps revision control
> is enough and we can just put git tree on kernel.org?

IMHO quilt will suffice to manage patches, at least for starters, but we'll
need a mailing list and an intro web page.

Greetings,
Rafael

