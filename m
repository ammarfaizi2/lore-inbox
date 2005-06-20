Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVFTXQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVFTXQg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVFTXCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:02:20 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:10371 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261576AbVFTWsa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:48:30 -0400
Date: Tue, 21 Jun 2005 04:15:44 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, jan malstrom <xanon@snacksy.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-mm1 (kernel BUG at fs/open.c:935!)
Message-ID: <20050620224544.GF4562@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <42B6BEC2.405@snacksy.com> <200506202318.37930.rjw@sisk.pl> <20050620212217.GD4562@in.ibm.com> <200506202341.19426.bero@arklinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506202341.19426.bero@arklinux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 11:41:18PM +0200, Bernhard Rosenkraenzer wrote:
> On Monday 20 June 2005 23:22, Dipankar Sarma wrote:
> > > > > Jun 20 14:38:07 hades kernel: kernel BUG at fs/open.c:935!
> >
> > Does it always happen with kded and always on reiser4 or does it happen
> > with other FS ? I tested with Jan's .config and couldn't reproduce it
> > in my P4 box. What exactly are you running in your machine ?
> 
> I'm seeing the same thing on a P4 box with ext3, so it's probably not 
> filesystem related.

Did you too see the problem with KDE userland ? It
always seem to happen with kded doing fcntl() or fcntl64().

> 
> I'm using gcc 3.4.4, binutils 2.16.90.0.3 - maybe it's yet another <kernel 
> developer>gcc bug</kernel developer><gcc developer>piece of crappy code in 
> the kernel that should never have worked with another version</gcc 
> developer> ;)

I am behind in my lab machines - gcc 3.2.2/3.2.3 binutils 2.14.x or so.
I am going find a box with newer userland and test 2.6.12-mm1 with
KDE to see if I can reproduce it there.

Thanks
Dipankar
