Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261522AbSJAIKF>; Tue, 1 Oct 2002 04:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbSJAIKF>; Tue, 1 Oct 2002 04:10:05 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:30336 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261522AbSJAIKF>;
	Tue, 1 Oct 2002 04:10:05 -0400
Date: Tue, 1 Oct 2002 03:15:18 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Greg KH <greg@kroah.com>
cc: Steven Cole <elenstev@mesatop.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.39 Oops on boot (device_attach+0x3a)
In-Reply-To: <20021001053957.GA5177@kroah.com>
Message-ID: <Pine.LNX.4.44.0210010313111.1429-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2002, Greg KH wrote:

> On Mon, Sep 30, 2002 at 07:13:02PM -0600, Steven Cole wrote:
> > I tried to boot 2.5.39 on my home machine and got the
> > following oops on boot with CONFIG_KALLSYMS=y (thanks Ingo!).
> 
> Do you have CONFIG_ISAPNP enabled?  If so, search the archives for the
> fix for this.  If not, please post your whole .config.

Just building the module shouldn't cause the oops though, should it?  I 
can get the same oops, but it is on loading sr_mod, not isapnp.  I have 
built isapnp.o but it never loads.

