Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270471AbTG1SsU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 14:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270473AbTG1SsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 14:48:19 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:31750
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270471AbTG1SsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 14:48:18 -0400
Date: Mon, 28 Jul 2003 12:03:30 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>, arjanv@redhat.com,
       Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove module reference counting.
Message-ID: <20030728190330.GE1686@matchmail.com>
Mail-Followup-To: Gianni Tedesco <gianni@scaramanga.co.uk>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Linus Torvalds <torvalds@osdl.org>,
	Stephen Hemminger <shemminger@osdl.org>,
	"David S. Miller" <davem@redhat.com>, arjanv@redhat.com,
	Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030727193919.832302C450@lists.samba.org> <1059415901.19143.3.camel@sherbert>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059415901.19143.3.camel@sherbert>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 07:11:42PM +0100, Gianni Tedesco wrote:
> On Sun, 2003-07-27 at 20:34, Rusty Russell wrote:
> > I guess it's back to fixing up reference counting in the rest of the
> > kernel.  It's not hard, it's just not done. 8(
> 
> Do you know which subsystems and modules are definately broken wrt.
> refcounting? And also which ones are un-fixable / wont-fix and why.
> 
> Maybe someone will step up to the plate if you name and shame...

At the very least, the network drivers have some trouble...
