Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265550AbUBAWcz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 17:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265552AbUBAWcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 17:32:55 -0500
Received: from waste.org ([209.173.204.2]:46254 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265550AbUBAWcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 17:32:52 -0500
Date: Sun, 1 Feb 2004 16:32:50 -0600
From: Matt Mackall <mpm@selenic.com>
To: aeriksson@fastmail.fm
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-tiny1 tree for small systems
Message-ID: <20040201223250.GX21888@waste.org>
References: <m1vfnc9eu7.fsf@ebiederm.dsl.xmission.com> <20040117112931.4D6223F60@latitude.mynet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117112931.4D6223F60@latitude.mynet.no-ip.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 12:29:27PM +0100, aeriksson@fastmail.fm wrote:
> > Which still leaves:
> > 
> > > arch/i386/mm/built-in.o(.init.text+0x2e6): In function `mem_init':
> > > : undefined reference to `ppro_with_ram_bug'
> > > drivers/built-in.o(__ksymtab+0x130): undefined reference to 
> > > `pci_pci_problems'
> > 
> 
> That one pops up if you don't have CPU support for Intel which, at least according to the menus, seems like a valid configuration.

That should be fixed in latest -tiny as well as some of the proc
stuff.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
