Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVADQVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVADQVZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 11:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVADQKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 11:10:09 -0500
Received: from styx.suse.cz ([82.119.242.94]:33493 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261708AbVADQHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 11:07:30 -0500
Date: Tue, 4 Jan 2005 17:08:30 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [bk patches] Long delayed input update
Message-ID: <20050104160830.GA13125@ucw.cz>
References: <20041227142821.GA5309@ucw.cz> <200412271419.46143.dtor_core@ameritech.net> <20050103131848.GH26949@ucw.cz> <Pine.LNX.4.58.0501032148210.2294@ppc970.osdl.org> <20050104135859.GA9167@ucw.cz> <Pine.LNX.4.58.0501040756230.2294@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501040756230.2294@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 07:58:50AM -0800, Linus Torvalds wrote:

> > What machine this was on? Kernel config won't allow you to unselect that
> > option if AT Keyboard is selected, and that's always selected when
> > CONFIG_PC is.

> Ahh. It's a G5 mac, so I guess it isn't needed. Even so, that thing 
> shouldn't show up. If I don't have AT keyboard _or_ mouse selected, it 
> shouldn't be there - they should "select" it, and if nothing uses it, then 
> there isn't anything to do. In no case should it show up as a question.

I can hide it, the reasoning was that it may be useful for out-of-kernel
modules, and because of that it's possible to enable it even when there
are no users, and only then it's an option.

atkbd and psmouse do "select" it.

> > > and has it in any way been tested on the millions of different
> > > versions of kbd controller clones out there?
> > 
> > Does a few months in Andrew's tree count?
> 
> So it has been part of the -mm tree? Good.

Yes.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
