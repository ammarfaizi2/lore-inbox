Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWKSRu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWKSRu0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 12:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWKSRu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 12:50:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:6333 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932270AbWKSRuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 12:50:25 -0500
X-Authenticated: #14349625
Subject: Re: [patch] PM: suspend/resume debugging should depend on 
	SOFTWARE_SUSPEND
From: Mike Galbraith <efault@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com>
	 <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org>
Content-Type: text/plain
Date: Sun, 19 Nov 2006 18:52:07 +0100
Message-Id: <1163958727.5977.15.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-19 at 09:33 -0800, Linus Torvalds wrote:
> 
> On Sun, 19 Nov 2006, Chuck Ebbert wrote:
> >
> > When doing 'make oldconfig' we should ask about suspend/resume
> > debug features when SOFTWARE_SUSPEND is not enabled.
> 
> That's wrong.
> 
> I never use SOFTWARE_SUSPEND, and I think the whole concept is totally 
> broken.
> 
> Sane people use suspend-to-ram, and that's when you need the suspend and 
> resume debugging.

Here I am wishing I had the _opportunity_ to be sane.  With my ATI X850
AGP card, I have no choices except swsusp or reboot.

	-Mike

