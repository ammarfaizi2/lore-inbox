Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTJYVak (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 17:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbTJYVak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 17:30:40 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:2321 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263129AbTJYVaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 17:30:39 -0400
Date: Sat, 25 Oct 2003 23:30:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Rob Landley <rob@landley.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: Kconfig choice menu help text is not working in -test8
Message-ID: <20031025213027.GB2249@mars.ravnborg.org>
Mail-Followup-To: Rob Landley <rob@landley.net>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <200310250244.56881.rob@landley.net> <20031025112637.GA901@mars.ravnborg.org> <200310251624.07665.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310251624.07665.rob@landley.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 25, 2003 at 04:24:07PM -0500, Rob Landley wrote:
> On Saturday 25 October 2003 06:26, Sam Ravnborg wrote:
> > On Sat, Oct 25, 2003 at 02:44:56AM -0500, Rob Landley wrote:
> > > I'm banging away on the bzip patch, adding a choice menu to kconfig for
> > > bzip/gzip/uncompressed, and I notice that the help text isn't working
> > > right.
> >
> > Anders Gustafsson <andersg@0x63.nu> posted this patch some time ago.
> > I never came around testing it.
> >
> > 	Sam
> 
> I just tested it.  No effect on this problem, maybe it fixes something else...
> 
> (Looking at the patch, it prints stuff to stderr, adds adds a "selected" case 
> to something that was previously on/off...  I don't think it's really 
> addressing this issue...)

That explains why Roman Zippel did not apply it - thanks for the testing.

	Sam
