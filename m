Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbUEANVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUEANVe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 09:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUEANVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 09:21:34 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:46599 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S262029AbUEANVd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 09:21:33 -0400
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5ghdv0i8w4.fsf@patl=users.sf.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Load hid.o module synchronously?
References: <s5g8ygi4l3q.fsf@patl=users.sf.net> <408D65A7.7060207@nortelnetworks.com> <s5gisfm34kq.fsf@patl=users.sf.net> <c6od9g$53k$1@gatekeeper.tmr.com>
Date: 01 May 2004 09:21:31 -0400
In-Reply-To: <mit.lcs.mail.linux-kernel/c6od9g$53k$1@gatekeeper.tmr.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

> Patrick J. LoPresti wrote:
>
> > I see how I can scan for a USB keyboard after loading the USB host
> > controller module.  I think.  But what do I look for, exactly, to
> > tell when hid.o has hooked itself up to the keyboard?
> 
> You need to be able to tell "not hooked yet" from "never saw it" for
> reliable operation. I don't know how to do that, sorry.

So there is no way to load this hardware driver and wait until it
either binds or fails to bind to its associated hardware?  That seems
like a bad bug in the design...

I suppose I will just use some arbitrary delay.

 - Pat
