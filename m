Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVA1AED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVA1AED (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 19:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVA0XvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:51:07 -0500
Received: from mail.tmr.com ([216.238.38.203]:17417 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261303AbVA0XgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:36:06 -0500
Date: Thu, 27 Jan 2005 18:12:10 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
In-Reply-To: <20050127192109.681b32b6@zanzibar.2ka.mipt.ru>
Message-ID: <Pine.LNX.3.96.1050127175637.32523A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005, Evgeniy Polyakov wrote:

> On Thu, 27 Jan 2005 10:19:51 -0500
> Bill Davidsen <davidsen@tmr.com> wrote:
> 
> > Evgeniy Polyakov wrote:
> > > On Mon, 24 Jan 2005 18:54:49 +0100
> > > Adrian Bunk <bunk@stusta.de> wrote:
> > > 
> > > 
> > >>It seems noone who reviewed the SuperIO patches noticed that there are 
> > >>now two modules "scx200" in the kernel...
> > > 
> > > 
> > > They are almost mutually exlusive(SuperIO contains more advanced), 
> > > so I do not see any problem here.
> > > Only one of them can be loaded in a time.
> > > 
> > > So what does exactly bother you?
> > >
> > That I don't know how to select loading between modules with the same 
> > name. What's the trick?
> 
> Use full path.
> Please see discussion in this thread related to module names.

Ah-ha! I looked at the man page instead of the code. It's not obvious the
"modulename" can be a full path, but the (possibly old) man page I have
for modprobe.conf could be out of date. I'll go look at the code.

Thanks.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

