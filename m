Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270257AbTGNQUA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270449AbTGNQUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:20:00 -0400
Received: from AMarseille-201-1-2-223.w193-253.abo.wanadoo.fr ([193.253.217.223]:23847
	"EHLO gaston") by vger.kernel.org with ESMTP id S270257AbTGNQT4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:19:56 -0400
Subject: Re: [Linux-fbdev-devel] fbdev and power management
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <20020105111340.GA2254@zaurus.ucw.cz>
References: <Pine.LNX.4.44.0307090024170.32323-100000@phoenix.infradead.org>
	 <1057750557.514.22.camel@gaston>
	 <20030709151032.A22612@flint.arm.linux.org.uk>
	 <20020105111340.GA2254@zaurus.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1058200445.515.23.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 14 Jul 2003 18:34:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-01-05 at 12:13, Pavel Machek wrote:
> Hi!
> 
> > I'm slightly concerned by this.  There are a growing amount of drivers
> > in 2.5 which are being made to work with the existing power management
> > system.  This "new" system seems to have been hanging around for about
> > 4 months now with no visible further work, presumably so that a paper
> > can be presented before its release.
> 
> I believe it is bad idea to change driver
> model again in 2.6.x-pre. I believe current
> solution is pretty much okay.

Current solution is not okay and actually, the save_state/suspend
distinction makes no sense. We have designed a working solution
a while ago now, Patrick has it implemented for month, it must
get in now or 2.6 will not have proper power management but just
"might work" kind of crap

Ben.


