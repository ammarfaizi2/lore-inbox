Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbUK3Aoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUK3Aoz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 19:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbUK3Aoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 19:44:55 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:32984 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261900AbUK3Aov
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 19:44:51 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] Ohci-hcd: fix endless loop (second take)
Date: Mon, 29 Nov 2004 16:41:51 -0800
User-Agent: KMail/1.7.1
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Colin Leroy <colin.lkml@colino.net>, Colin Leroy <colin@colino.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
References: <20041126113021.135e79df@pirandello> <20041129233435.4e0d125c@jack.colino.net> <1101768195.15463.20.camel@gaston>
In-Reply-To: <1101768195.15463.20.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411291641.51559.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 November 2004 2:43 pm, Benjamin Herrenschmidt wrote:
> On Mon, 2004-11-29 at 23:34 +0100, Colin Leroy wrote:
> 
> Ok, this is a perfectly normal "out of the schelves" NEC chip, no
> special "Mac" thing in there, it just use normal PCI PM...
> 
> It could be one of the devices not properly dealing with beeing
> suspended, or it could be some delay needing to be increased here or
> there in the resume process, difficult to say at this point.

Or as I said before, it's probably one of the issues fixed
in the USB PM patches in 2.6.10-rc2 ... really, it's not
even worth testing that with straight 2.6.9 kernels.  

