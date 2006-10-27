Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946075AbWJ0BVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946075AbWJ0BVB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 21:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946077AbWJ0BVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 21:21:01 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:35537 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1946075AbWJ0BVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 21:21:00 -0400
Date: Thu, 26 Oct 2006 19:20:58 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [RFC: 2.6.19 patch] let PCI_MULTITHREAD_PROBE depend on BROKEN
Message-ID: <20061027012058.GH5591@parisc-linux.org>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <20061026224541.GQ27968@stusta.de> <20061027010252.GV27968@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061027010252.GV27968@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 03:02:52AM +0200, Adrian Bunk wrote:
> PCI_MULTITHREAD_PROBE is an interesting feature, but in it's current 
> state it seems to be more of a trap for users who accidentally
> enable it.
> 
> This patch lets PCI_MULTITHREAD_PROBE depend on BROKEN for 2.6.19.
> 
> The intention is to get this patch reversed in -mm as soon as it's in 
> Linus' tree, and reverse it for 2.6.20 or 2.6.21 after the fallout of 
> in-kernel problems PCI_MULTITHREAD_PROBE causes got fixed.

People who enable features clearly marked as EXPERIMENTAL deserve what
they get, IMO.
