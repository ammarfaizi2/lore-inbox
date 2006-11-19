Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932934AbWKSTBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932934AbWKSTBf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 14:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932941AbWKSTBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 14:01:35 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:32951 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932934AbWKSTBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 14:01:33 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] PM: suspend/resume debugging should depend on  SOFTWARE_SUSPEND
Date: Sun, 19 Nov 2006 19:58:14 +0100
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org> <1163958727.5977.15.camel@Homer.simpson.net>
In-Reply-To: <1163958727.5977.15.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611191958.15152.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 19 November 2006 18:52, Mike Galbraith wrote:
> On Sun, 2006-11-19 at 09:33 -0800, Linus Torvalds wrote:
> > 
> > On Sun, 19 Nov 2006, Chuck Ebbert wrote:
> > >
> > > When doing 'make oldconfig' we should ask about suspend/resume
> > > debug features when SOFTWARE_SUSPEND is not enabled.
> > 
> > That's wrong.
> > 
> > I never use SOFTWARE_SUSPEND, and I think the whole concept is totally 
> > broken.
> > 
> > Sane people use suspend-to-ram, and that's when you need the suspend and 
> > resume debugging.
> 
> Here I am wishing I had the _opportunity_ to be sane.  With my ATI X850
> AGP card, I have no choices except swsusp or reboot.

Have you tried s2ram (http://en.opensuse.org/S2ram)?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
