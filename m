Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUEECt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUEECt6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 22:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUEECt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 22:49:58 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:62732 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S261234AbUEECt5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 22:49:57 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Load hid.o module synchronously?
References: <s5g8ygi4l3q.fsf@patl=users.sf.net>
	<408D65A7.7060207@nortelnetworks.com>
	<s5gisfm34kq.fsf@patl=users.sf.net> <c6od9g$53k$1@gatekeeper.tmr.com>
	<s5ghdv0i8w4.fsf@patl=users.sf.net> <20040504200147.GA26579@kroah.com>
	<s5ghduvdg1u.fsf@patl=users.sf.net> <20040504223550.GA32155@kroah.com>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gy8o7bnhv.fsf@patl=users.sf.net>
Date: 04 May 2004 22:49:56 -0400
In-Reply-To: <20040504223550.GA32155@kroah.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Tue, May 04, 2004 at 05:56:48PM -0400, Patrick J. LoPresti wrote:
>
> > But what if it fails to bind?  For example, what if an error occurs?
> > Or what if the keyboard is on the module's blacklist?  How do I know
> > when to stop waiting?
> 
> You do not, sorry.

That is disappointing.  I mean, I deal with Microsoft products a lot,
where "unreliable by design" is normal.  But I expected better from
Linux.

> > Ideally, what I would like is for "modprobe <driver>" to wait
> > until all hardware handled by that driver is either ready for use
> > or is never going to be.  That seems simple and natural to me.
> 
> Sorry, but this is not going to happen.  It does not fit into the
> way the kernel handles drivers anymore.  Again, sorry.

OK, an arbitrary flaky delay it is.  Thanks!

 - Pat
