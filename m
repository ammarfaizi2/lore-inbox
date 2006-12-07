Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032397AbWLGQkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032397AbWLGQkQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 11:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032395AbWLGQkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 11:40:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42422 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032388AbWLGQkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 11:40:14 -0500
Date: Thu, 7 Dec 2006 11:37:03 -0500
From: Alan Cox <alan@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Daniel Drake <dsd@gentoo.org>, Alan Cox <alan@redhat.com>,
       Chris Wedgwood <cw@f00f.org>, Daniel Ritz <daniel.ritz@gmx.ch>,
       Jean Delvare <khali@linux-fr.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Linus Torvalds <torvalds@osdl.org>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>,
       Tomasz Koprowski <tomek@koprowski.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: RFC: PCI quirks update for 2.6.16
Message-ID: <20061207163703.GB16103@devserv.devel.redhat.com>
References: <20061207132430.GF8963@stusta.de> <45782774.8060002@gentoo.org> <20061207145755.GI8963@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207145755.GI8963@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 03:57:56PM +0100, Adrian Bunk wrote:
> Looking at Alan's patch in -mm, it seems the best current solution for 
> 2.6.16 is to go back to the pre-2.6.16.17
>   DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
> and revisit this after Alan's patch was released with 2.6.20?

If you want 2.6.16.* not to risk any reversions of good behaviour then I'd agree
I'm pretty sure the new code is right cool and wonderful *BUT* it may not be
of course and it may also break broken bioses differently 8(
