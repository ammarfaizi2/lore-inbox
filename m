Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVADP7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVADP7G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 10:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVADP7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 10:59:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:30136 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261694AbVADP7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 10:59:02 -0500
Date: Tue, 4 Jan 2005 07:58:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [bk patches] Long delayed input update
In-Reply-To: <20050104135859.GA9167@ucw.cz>
Message-ID: <Pine.LNX.4.58.0501040756230.2294@ppc970.osdl.org>
References: <20041227142821.GA5309@ucw.cz> <200412271419.46143.dtor_core@ameritech.net>
 <20050103131848.GH26949@ucw.cz> <Pine.LNX.4.58.0501032148210.2294@ppc970.osdl.org>
 <20050104135859.GA9167@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Jan 2005, Vojtech Pavlik wrote:
> 
> What machine this was on? Kernel config won't allow you to unselect that
> option if AT Keyboard is selected, and that's always selected when
> CONFIG_PC is.

Ahh. It's a G5 mac, so I guess it isn't needed. Even so, that thing 
shouldn't show up. If I don't have AT keyboard _or_ mouse selected, it 
shouldn't be there - they should "select" it, and if nothing uses it, then 
there isn't anything to do. In no case should it show up as a question.

> > and has it in any way been tested on the millions of different
> > versions of kbd controller clones out there?
> 
> Does a few months in Andrew's tree count?

So it has been part of the -mm tree? Good.

		Linus
