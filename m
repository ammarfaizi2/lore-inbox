Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264323AbTLaMVn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 07:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbTLaMVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 07:21:43 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:38633 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S264323AbTLaMVm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 07:21:42 -0500
Date: Wed, 31 Dec 2003 07:17:53 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [2.6.0-mm2] slab corruption during packet flood on e100
Message-ID: <20031231121753.GA13178@gnu.org>
References: <20031231105227.GA9429@gnu.org> <20031231032313.049c52d7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031231032313.049c52d7.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
From: Lennert Buytenhek <buytenh@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 03:23:13AM -0800, Andrew Morton wrote:

> > When routing a large stream of UDP packets through this machine, coming
> >  in on eth1 (e100), headed towards dummy0, I get a flood of slab corruption
> >  messages a la below.  Box is a 2-way HT SMP machine.
> > 
> >  Is this a known problem with the e100 driver perhaps?
> 
> The experimental net driver tree has what appears to be a big e100 rewrite
> in it.  Can you test 2.6.1-rc1 sometime?

2.6.1-rc1 seems just fine.  No packet drops, no overruns, and most
importantly, no slab corruption warnings.


--L
