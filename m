Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWBKP3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWBKP3h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 10:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWBKP3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 10:29:37 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:59798 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932323AbWBKP3g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 10:29:36 -0500
Date: Sat, 11 Feb 2006 16:29:30 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Doug McNaught <doug@mcnaught.org>
Cc: Marc Koschewski <marc@osknowledge.org>, Kyle Moffett <mrmacman_g4@mac.com>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Linux-LKLM <linux-kernel@vger.kernel.org>
Subject: Re: [BUG GIT] Unable to handle kernel paging request at virtual address e1380288
Message-ID: <20060211152930.GC5721@stiffy.osknowledge.org>
References: <20060210214122.GA13881@stiffy.osknowledge.org> <20060210222515.GA4793@mipter.zuzino.mipt.ru> <20060210224238.GA5713@stiffy.osknowledge.org> <269F4ADB-FA82-47DD-9087-D07CA11DD681@mac.com> <20060211151005.GA5721@stiffy.osknowledge.org> <87y80hsz26.fsf@asmodeus.mcnaught.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y80hsz26.fsf@asmodeus.mcnaught.org>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g25bf368b-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Doug McNaught <doug@mcnaught.org> [2006-02-11 10:19:29 -0500]:

> Marc Koschewski <marc@osknowledge.org> writes:
> 
> > Moreover, I don't know in what way a PCI graphics adapter is pissing off USB
> > devices. Is there a chance to?
> 
> Sure.  Drivers run in kernel mode and, if buggy, can scribble all over

Sure thing.

> any part of kernel memory, causing problems in completely unrelated
> places.

But the trace I sent didn't (directly) do any memory allocation so the case was
clear to me.

>From a developers point of view I totally agree that doing some bad code 'here'
might crash us 'there'. But the backtrace didn't look like this to me...

Marc
