Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262953AbVCJSbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbVCJSbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 13:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbVCJSYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 13:24:41 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:65530 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262845AbVCJSSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 13:18:30 -0500
Date: Thu, 10 Mar 2005 11:18:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "David S. Miller" <davem@davemloft.net>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: bk commits and dates
Message-ID: <20050310181809.GX3098@smtp.west.cox.net>
References: <1110422519.32556.159.camel@gaston> <20050309194744.6aef66b7.davem@davemloft.net> <1110433821.32524.176.camel@gaston> <422FE571.7010101@pobox.com> <1110463905.4026.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110463905.4026.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 07:11:45AM -0700, David Woodhouse wrote:
> On Thu, 2005-03-10 at 01:13 -0500, Jeff Garzik wrote:
> > Speaking strictly in terms of implementation, David Woodhouse's 
> > bk-commits mailer scripts could probably easily be tweaked to -not- set 
> > an explicit Date header on the outgoing emails.
> > 
> > It then becomes a matter of deciding whether this is a good idea or not :)
> 
> The original changeset date is also in the body of the mail anyway so it
> wouldn't be lost if we changed this. I have no real preference either
> way. Bear in mind that the Date: header you got would then be the time
> my script ran, not the time it was actually committed. That may differ
> by days, in some cases (thankfully not often).

I've just been using sort by arrival as an imperfect, but still mostly
correct work-around (a few things have shown up after the email with the
tag, but only a few).  I'd argue having the mails have the fuged date is
useful when trying to re-create sub-sets of a given tree.

Note that for the specific problem Ben has (looking at all ChangeSets
from A to B), I've got a kinda slow script that fakes the bk-commits
messages given two repositories, if this sounds of any interest to
anyone.

-- 
Tom Rini
http://gate.crashing.org/~trini/
