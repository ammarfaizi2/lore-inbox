Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVADFxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVADFxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 00:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVADFxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 00:53:36 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:21005 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262045AbVADFxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 00:53:35 -0500
Date: Tue, 4 Jan 2005 06:44:58 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Felipe Alfaro Solana <lkml@mac.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@debian.org>
Subject: Re: starting with 2.7
Message-ID: <20050104054458.GB7048@alpha.home.local>
References: <6D2C0E07-5DAE-11D9-9FD3-000D9352858E@mac.com> <200501032059.j03KxOEB004666@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501032059.j03KxOEB004666@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 05:59:24PM -0300, Horst von Brand wrote:
> Felipe Alfaro Solana <lkml@mac.com> said:
> 
> [...]
> 
> > I would like to comment in that the issue is not exclusively targeted 
> > to stability, but the ability to keep up with kernel development. For 
> > example, it was pretty common for older versions of VMWare and NVidia 
> > driver to break up whenever a new kernel version was released.
> 
> That is the price for closed-source drivers.
> 
> > I think it's a PITA for developers to rework some of the closed-source 
> > code to adopt the new changes in the Linux kernel.
> 
> Open up the code. Most of the changes will then be done as a matter of
> course by others.

it will not solve the problem : if a driver or any glue logic breaks, it's
because interface has changed again. When you will have 3000 open drivers,
you'll have to find people to make the changes every week. The solution in
the first place is to respect some code stability and not to break thinks
every week.

Willy

