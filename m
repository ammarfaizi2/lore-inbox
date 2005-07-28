Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVG1Qs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVG1Qs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 12:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVG1QrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:47:15 -0400
Received: from hera.kernel.org ([209.128.68.125]:18342 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261703AbVG1QpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:45:05 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: driver for Marvell 88E8053 PCI Express Gigabit LAN
Date: Thu, 28 Jul 2005 09:45:14 -0700
Organization: OSDL
Message-ID: <20050728094514.6ed25d12@localhost.localdomain>
References: <dc9252$tgr$1@sea.gmane.org>
	<dc94v3$40c$1@sea.gmane.org>
	<42E8CD48.7090008@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1122569095 31981 10.8.0.74 (28 Jul 2005 16:44:55 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 28 Jul 2005 16:44:55 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.11 (GTK+ 2.6.7; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005 13:19:20 +0100
Daniel Drake <dsd@gentoo.org> wrote:

> Hi Alexander,
> 
> Alexander Fieroch wrote:
> > Alexander Fieroch wrote:
> > 
> >> http://dlsvr01.asus.com/pub/ASUS/lan/marvell/8053/8053_others2.zip
> > 
> > 
> > Oh, that driver is very old. Here is the latest one which is
> > working with the current kernel:
> > 
> > http://www.syskonnect.de/syskonnect/support/driver/htm/sk9elin.htm
> > 
> > Could you please integrate it to the kernel?
> 
> Syskonnect's latest changes to the sk98lin driver do not adhere to
> Linux coding standards -- they have basically crammed two drivers
> into one in an ugly fashion. It won't be included in the mainline
> kernel in this form.
> 
> Part of sk98lin has been rewritten as skge (this supports the Yukon-
> based PCI adapters) which will be included in 2.6.13.
> 
> In order to support the newer Yukon-II (PCI express) adapters in an
> acceptable fashion, a new driver will need to be written, skge-style.
> I don't think this is in development just yet. Perhaps you could try
> contacting Syskonnect/Marvell yourself to get them to help out
> developing a driver fit for inclusion.
> 
I am working on a sky2 driver modeled on skge.  It is taking baby steps
now.
