Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbTIHR0n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 13:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTIHR0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 13:26:43 -0400
Received: from havoc.gtf.org ([63.247.75.124]:32211 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263436AbTIHR0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 13:26:41 -0400
Date: Mon, 8 Sep 2003 13:26:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Fedor Karpelevitch <fedor@karpelevitch.net>
Cc: Abraham van der Merwe <abz@frogfoot.net>,
       Linux Kernel Discussions <linux-kernel@vger.kernel.org>
Subject: Re: possibly bug in 8139cp? (WAS Re: BUG: 2.4.23-pre3 + ifconfig)
Message-ID: <20030908172641.GB21226@gtf.org>
References: <20030904180554.GA21536@oasis.frogfoot.net> <200309071217.03470.fedor@karpelevitch.net> <20030907191552.GA26123@oasis.frogfoot.net> <200309080943.26254.fedor@karpelevitch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309080943.26254.fedor@karpelevitch.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 09:43:25AM -0700, Fedor Karpelevitch wrote:
> > > > I just installed 2.4.23-pre3 on one of our servers. If I
> > > > up/down the loopback device multiple times ifconfig hangs on
> > > > the second down (as in unkillable) and afterwards ifconfig
> > > > stops functioning and I can't reboot the machine, etc.

This sounds like the NAPI bug we're chasing.

	Jeff


	
