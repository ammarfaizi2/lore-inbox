Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVCKTZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVCKTZe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVCKTWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:22:16 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:18841 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261563AbVCKTSe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:18:34 -0500
Subject: Re: User mode drivers: part 2: PCI device handling (patch 1/2 for
	2.6.11)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16945.22566.593812.759201@wombat.chubb.wattle.id.au>
References: <16945.4717.402555.893411@berry.gelato.unsw.EDU.AU>
	 <20050311071825.GA28613@kroah.com>
	 <16945.22566.593812.759201@wombat.chubb.wattle.id.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110568598.15943.78.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 11 Mar 2005 19:16:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-03-11 at 08:34, Peter Chubb wrote:
> Greg> If you make it a real, mountable filesystem, then you don't need
> Greg> to have any of your new syscalls, right?  Why not just do that
> Greg> instead?

> The only call that would go is usr_pci_open() -- you'd still need 
> usr_pci_map(), usr_pci_unmap() and usr_pci_get_consistent().

mmap, munmap, mmap with M_SYNC 

