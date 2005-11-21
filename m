Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbVKUURS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbVKUURS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbVKUURS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:17:18 -0500
Received: from [205.233.219.253] ([205.233.219.253]:59575 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1750777AbVKUURR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:17:17 -0500
Date: Mon, 21 Nov 2005 15:14:29 -0500
From: Jody McIntyre <scjody@steamballoon.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/3] Add SCM info to MAINTAINERS
Message-ID: <20051121201429.GE20781@conscoop.ottawa.on.ca>
References: <20051118173930.270902000@press.kroah.org> <20051118173106.GB20860@kroah.com> <20051120213846.GB2556@spitz.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051120213846.GB2556@spitz.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2005 at 09:38:47PM +0000, Pavel Machek wrote:
> >  W: Web-page with status/info
> > +T: SCM tree type and URL.  Type is one of: git, hg, quilt.
> >  S: Status, one of the following:
> 
> You are not actually putting urls there. url is git://kernel.org/...

Good point.  How should we fix this?  s/URL/location/ ?  I don't think
we should put git://kernel.org... in the T: field since there are many
valid ways of accessing this repository: git, http, rsync, ssh (if you
have an account).

Cheers,
Jody

> 
> > @@ -183,6 +184,7 @@ P:	Len Brown
> >  M:	len.brown@intel.com
> >  L:	acpi-devel@lists.sourceforge.net
> >  W:	http://acpi.sourceforge.net/
> > +T:	git kernel.org:/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git
> >  S:	Maintained
> >  
> >  AD1816 SOUND DRIVER
> 							Pavel
> -- 
> 64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

-- 
