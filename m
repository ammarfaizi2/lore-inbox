Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271114AbTG1UjQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271113AbTG1UjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:39:12 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:46601 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S271107AbTG1Uim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:38:42 -0400
Date: Mon, 28 Jul 2003 22:38:38 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2: cursor started to disappear
Message-ID: <20030728203838.GB1815@win.tue.nl>
References: <20030728181408.GA499@elf.ucw.cz> <20030728182757.GA1793@win.tue.nl> <20030728131741.528a4707.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728131741.528a4707.akpm@osdl.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 01:17:41PM -0700, Andrew Morton wrote:
> Andries Brouwer <aebr@win.tue.nl> wrote:
> >
> > On Mon, Jul 28, 2003 at 08:14:08PM +0200, Pavel Machek wrote:
> > 
> > > Plus I'm seeing some silent data corruption. It may be
> > > swsusp or loop related
> > 
> > Loop is not stable at all. Unsuitable for daily use.
> 
> That's the first I've heard about it.  Do you have some details on this?  A
> test case perhaps?

Yes, there are many reports, and it is easy to confirm.

By some coincidence just a moment ago we saw the announcement of
Bugzilla bug 1000:

[Bug 1000] New: file corruption using cryptoloop on ext2/ext3


Andries

