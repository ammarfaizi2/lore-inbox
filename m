Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263755AbTDGWtz (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263757AbTDGWty (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:49:54 -0400
Received: from crack.them.org ([65.125.64.184]:4320 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id S263755AbTDGWtw (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 18:49:52 -0400
Date: Mon, 7 Apr 2003 19:00:42 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Martin Schlemmer <azarah@gentoo.org>, Russell King <rmk@arm.linux.org.uk>,
       Keith Owens <kaos@ocs.com.au>, KML <linux-kernel@vger.kernel.org>
Subject: Re: correct to set -nostdinc and then include <stdarg.h> ?
Message-ID: <20030407230041.GA14265@nevyn.them.org>
Mail-Followup-To: Chris Friesen <cfriesen@nortelnetworks.com>,
	Martin Schlemmer <azarah@gentoo.org>,
	Russell King <rmk@arm.linux.org.uk>, Keith Owens <kaos@ocs.com.au>,
	KML <linux-kernel@vger.kernel.org>
References: <3E910172.8030406@nortelnetworks.com> <23076.1049692512@kao2.melbourne.sgi.com> <20030407074722.A9367@flint.arm.linux.org.uk> <3E91866C.2000902@nortelnetworks.com> <1049724971.4773.2493.camel@workshop.saharact.lan> <3E918ED6.1090706@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E918ED6.1090706@nortelnetworks.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 10:44:38AM -0400, Chris Friesen wrote:
> Martin Schlemmer wrote:
> 
> >You might just have to give --bindir, etc to the exact locations.
> >Also, make sure you do not have symlinks, etc in /usr/bin, as they
> >sometimes 'confuses' gcc ...
> 
> Hmm...maybe that's it.  I've got /usr/local/bin/gcc322 symlinked to 
> /usr/local/gcc322/bin/gcc.  The equivalent link works with gcc 2.95.3 
> though...

It'll work again with GCC 3.4, IIRC.  But 3.2 and the upcoming 3.3
release have problems with symlinks.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
