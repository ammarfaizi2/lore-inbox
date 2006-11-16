Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424081AbWKPOJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424081AbWKPOJL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 09:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424089AbWKPOJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 09:09:11 -0500
Received: from zeus.pimb.org ([80.68.88.21]:56847 "EHLO zeus.pimb.org")
	by vger.kernel.org with ESMTP id S1424081AbWKPOJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 09:09:10 -0500
Date: Thu, 16 Nov 2006 14:31:48 +0000
From: Jody Belka <lists-lkml@pimb.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [Suspend-devel] problem after s2ram restore with password-protected hdd
Message-ID: <20061116143148.GS2808@pimb.org>
References: <20061116135210.GR2808@pimb.org> <200611161453.56789.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611161453.56789.rjw@sisk.pl>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please cc me on any reply, as i'm not subscribed]

On Thu, Nov 16, 2006 at 02:53:56PM +0100, Rafael J. Wysocki wrote:
> On Thursday, 16 November 2006 14:52, Jody Belka wrote:
> > I tried to use s2ram today on my Dell Inspiron 6000, but i'm having problems
> > after wake-up when I have the hard drives internal password enabled (the
> > normal state for this machine). If i turn the password off, everything works
> > fine. I note that the password screen doesn't appear during wake-up, although
> > the bios help text implies that it should do.
> 
> Well, this is a long-standing issue that hasn't been resolved yet.  There is
> a patch available from http://bugzilla.kernel.org/show_bug.cgi?id=6840
> but it is known to have problems.

Ah, thanks. And unfortunately i can't try out that patch anyway i believe, as
it looks to me to be for the old ide subsystem, not libata. Oh well, i'll just
have to live without s2ram for a while longer then i guess.


J
-- 
Jody Belka
<knew (at) pimb (dot) org>
