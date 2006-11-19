Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWKSRrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWKSRrz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 12:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWKSRrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 12:47:55 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:51126 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932313AbWKSRry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 12:47:54 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] PM: suspend/resume debugging should depend on  SOFTWARE_SUSPEND
Date: Sun, 19 Nov 2006 18:44:13 +0100
User-Agent: KMail/1.9.1
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611191844.14354.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 19 November 2006 18:33, Linus Torvalds wrote:
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
> 
> Software-suspend is silly. I want my machine back in three seconds, not 
> waiting for minutes..

In fact that's up to 30 seconds on a modern box, usually less than that.

And suspend-to-ram doesn't work on quilte a lot of boxes right now.  Also, you
can use the software suspend on boxes that don't support the suspend-to-ram
at all.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
