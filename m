Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUEDUDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUEDUDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 16:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUEDUDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 16:03:15 -0400
Received: from mail.kroah.org ([65.200.24.183]:24501 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264246AbUEDUDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 16:03:12 -0400
Date: Tue, 4 May 2004 13:01:47 -0700
From: Greg KH <greg@kroah.com>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Load hid.o module synchronously?
Message-ID: <20040504200147.GA26579@kroah.com>
References: <s5g8ygi4l3q.fsf@patl=users.sf.net> <408D65A7.7060207@nortelnetworks.com> <s5gisfm34kq.fsf@patl=users.sf.net> <c6od9g$53k$1@gatekeeper.tmr.com> <s5ghdv0i8w4.fsf@patl=users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ghdv0i8w4.fsf@patl=users.sf.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 09:21:31AM -0400, Patrick J. LoPresti wrote:
> Bill Davidsen <davidsen@tmr.com> writes:
> 
> > Patrick J. LoPresti wrote:
> >
> > > I see how I can scan for a USB keyboard after loading the USB host
> > > controller module.  I think.  But what do I look for, exactly, to
> > > tell when hid.o has hooked itself up to the keyboard?
> > 
> > You need to be able to tell "not hooked yet" from "never saw it" for
> > reliable operation. I don't know how to do that, sorry.
> 
> So there is no way to load this hardware driver and wait until it
> either binds or fails to bind to its associated hardware?  That seems
> like a bad bug in the design...

Um, what is wrong with the proposals I made for how you can detect this?

greg k-h
