Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268677AbUJKEEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268677AbUJKEEZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 00:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268678AbUJKEEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 00:04:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:49346 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268677AbUJKEEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 00:04:23 -0400
Date: Sun, 10 Oct 2004 21:04:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       David Brownell <david-b@pacbell.net>
Subject: Re: Totally broken PCI PM calls
In-Reply-To: <16746.299.189583.506818@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.58.0410102102140.3897@ppc970.osdl.org>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
 <16746.299.189583.506818@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Oct 2004, Paul Mackerras wrote:
> 
> The USB drivers aren't a good example, they are currently quite broken
> as far as suspend/resume is concerned.  They used to work just fine
> but got broken some time in the last few months.

And they are unbroken again (well, at least they work for me again).  
Partly by the PM_ renumbering under discussion.

> The problem I have at the moment is that PCI drivers get asked to go
> to D3 for both suspend-to-ram and suspend-to-disk.  In particular the
> radeonfb driver wants to do different things in these two cases.

Hey, I don't disagree. But I pointed out why it's done the way it is done. 
I even told you what can be done about it - so please argue _those_ points 
instead of just ignoring them.

		Linus
