Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271021AbTG1UtP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271030AbTG1UtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:49:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:64481 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271021AbTG1UqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:46:00 -0400
Date: Mon, 28 Jul 2003 13:34:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2: cursor started to disappear
Message-Id: <20030728133431.0a4825ca.akpm@osdl.org>
In-Reply-To: <20030728203838.GB1815@win.tue.nl>
References: <20030728181408.GA499@elf.ucw.cz>
	<20030728182757.GA1793@win.tue.nl>
	<20030728131741.528a4707.akpm@osdl.org>
	<20030728203838.GB1815@win.tue.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> wrote:
>
> On Mon, Jul 28, 2003 at 01:17:41PM -0700, Andrew Morton wrote:
> > Andries Brouwer <aebr@win.tue.nl> wrote:
> > >
> > > On Mon, Jul 28, 2003 at 08:14:08PM +0200, Pavel Machek wrote:
> > > 
> > > > Plus I'm seeing some silent data corruption. It may be
> > > > swsusp or loop related
> > > 
> > > Loop is not stable at all. Unsuitable for daily use.
> > 
> > That's the first I've heard about it.  Do you have some details on this?  A
> > test case perhaps?
> 
> Yes, there are many reports, and it is easy to confirm.
> 
> By some coincidence just a moment ago we saw the announcement of
> Bugzilla bug 1000:
> 
> [Bug 1000] New: file corruption using cryptoloop on ext2/ext3

That's cryptoloop.  I thought you were referring to vanilla loop.

Are you saying that the problems are only with cryptoloop, or does normal
old loop have some bug?

