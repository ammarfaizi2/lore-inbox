Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTIXXur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 19:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbTIXXur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 19:50:47 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:24072 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261575AbTIXXuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 19:50:44 -0400
Date: Thu, 25 Sep 2003 01:50:41 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rfc: test whether a device has a partition table
Message-ID: <20030924235041.GA21416@win.tue.nl>
References: <UTC200309242029.h8OKTo008219.aeb@smtp.cwi.nl> <bkt3qe$imh$1@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bkt3qe$imh$1@build.pdx.osdl.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 02:54:21PM -0700, Linus Torvalds wrote:

> Repeat after me: make the defaults so sane that most people don't even
> have to think about it.
> 
> In short, I think your first sentence (upon which the rest of the argument
> depends) is just quite _fundamentally_ flawed.

Ha, Linus - didn't you know I am always right?

But being right in theory - like you say, I have repeated these
things for many years - is not enough to submit a kernel patch.
The post of today was prompted by a mail about
certain USB devices:

> On closer examination it seems to be the partition table
> which is read ok (as one partition) on W2K and XP
> but Linux (both 2.4 and 2.6) gets really confused and
> thinks there are 4 malformed partitions.

and

> Linux probably needs to handle this situation more
> gracefully. A local police force bought a bunch of
> these devices for Linux based forensic work. They
> are a bit disappointed at the moment.

So, now not only theory but also practice is involved, and
we must do something.

My post implicitly suggested the minimal thing to do.
It will not be enough - heuristics are never enough -
but it probably helps in most cases.

I wait a little for reactions, and hope to send you a patch later.

Andries

