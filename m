Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946080AbWJ0BcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946080AbWJ0BcJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 21:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946083AbWJ0BcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 21:32:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51176 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946080AbWJ0BcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 21:32:07 -0400
Date: Thu, 26 Oct 2006 18:28:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [RFC: 2.6.19 patch] let PCI_MULTITHREAD_PROBE depend on BROKEN
Message-Id: <20061026182838.ac2c7e20.akpm@osdl.org>
In-Reply-To: <20061027012058.GH5591@parisc-linux.org>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
	<20061026224541.GQ27968@stusta.de>
	<20061027010252.GV27968@stusta.de>
	<20061027012058.GH5591@parisc-linux.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2006 19:20:58 -0600
Matthew Wilcox <matthew@wil.cx> wrote:

> On Fri, Oct 27, 2006 at 03:02:52AM +0200, Adrian Bunk wrote:
> > PCI_MULTITHREAD_PROBE is an interesting feature, but in it's current 
> > state it seems to be more of a trap for users who accidentally
> > enable it.
> > 
> > This patch lets PCI_MULTITHREAD_PROBE depend on BROKEN for 2.6.19.
> > 
> > The intention is to get this patch reversed in -mm as soon as it's in 
> > Linus' tree, and reverse it for 2.6.20 or 2.6.21 after the fallout of 
> > in-kernel problems PCI_MULTITHREAD_PROBE causes got fixed.
> 
> People who enable features clearly marked as EXPERIMENTAL deserve what
> they get, IMO.

It's not the impact on "people" which is of concern - it's the impact on
kernel developers - specifically those who spend time looking at bug
reports :(
