Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965105AbVHPFOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbVHPFOt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 01:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbVHPFOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 01:14:49 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:58064 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S965105AbVHPFOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 01:14:48 -0400
X-ORBL: [63.205.185.3]
Date: Mon, 15 Aug 2005 22:14:34 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Doug Warzecha <Douglas_Warzecha@dell.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Message-ID: <20050816051434.GB25224@taniwha.stupidest.org>
References: <20050815200522.GA3667@sysman-doug.us.dell.com> <AC1976B5-FAFC-4809-B1B2-579D5F14FDFE@mac.com> <20050816043451.GA25224@taniwha.stupidest.org> <C38BFC4F-E00F-4CE8-A4DD-89AE55B898D9@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C38BFC4F-E00F-4CE8-A4DD-89AE55B898D9@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 12:55:35AM -0400, Kyle Moffett wrote:

> I'm worried that it might be more of a mess in userspace than it
> could be if done properly in the kernel.

I would rather if it's gonna be a mess it's, then we put that mess in
userspace rather than in the kernel.

> Hardware drivers, especially for something as critical as the BIOS,
> should probably be done in-kernel.

For the most part it's not for the BIOS though AFAICT.  It's for some
hacky little microcontroller that controls fans and similar things
that Dell won't give up details for.

> Look at the mess that X has become, it mmaps /dev/mem and pokes at
> the PCI busses directly.  I just don't want an MSI-driver to become
> another /dev/mem.

It's for old hardware, I'm not sure it will evolve much other than
just for maintenance.

It's really hard to say, maybe if Dell gave more details about the
userspace we would have a better idea?

