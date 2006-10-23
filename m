Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWJWW6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWJWW6a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 18:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbWJWW6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 18:58:30 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:38069 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1750820AbWJWW6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 18:58:30 -0400
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, rjw@sisk.pl, linux-kernel@vger.kernel.org
In-Reply-To: <20061023105022.8b1dc75d.akpm@osdl.org>
References: <1161576735.3466.7.camel@nigel.suspend2.net>
	 <200610231236.54317.rjw@sisk.pl>
	 <1161605379.3315.23.camel@nigel.suspend2.net>
	 <200610231607.17525.rjw@sisk.pl> <20061023095522.e837ad89.akpm@osdl.org>
	 <20061023171450.GA3766@elf.ucw.cz>  <20061023105022.8b1dc75d.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 08:58:26 +1000
Message-Id: <1161644306.7033.18.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2006-10-23 at 10:50 -0700, Andrew Morton wrote:
> > On Mon, 23 Oct 2006 19:14:50 +0200 Pavel Machek <pavel@ucw.cz> wrote:
> > On Mon 2006-10-23 09:55:22, Andrew Morton wrote:
> > > > On Mon, 23 Oct 2006 16:07:16 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > > I'm trying to prepare the patches to make swsusp into suspend2.
> > > > 
> > > > Oh, I see.  Please don't do that.
> > > 
> > > Why not?
> > 
> > Last time I checked, suspend2 was 15000 lines of code, including its
> > own plugin system and special user-kernel protocol for drawing
> > progress bar (netlink based). It also did parts of user interface from
> 
> That's different.

Let's judge those bits when we see them, rather than going on rumour and
inuendo :)

> I don't know where these patches are leading, but thus far they look like
> reasonable cleanups and generalisations.  So I suggest we just take them
> one at a time.

I am seeking to produce patches to merge Suspend2 one bit at a time, as
has been requested in the past. I'd therefore ask that you do that,
because even if Pavel and Rafael don't like the overall thrust, it
doesn't mean you can't cherry pick what is good and useful along the
way.

Regards,

Nigel

