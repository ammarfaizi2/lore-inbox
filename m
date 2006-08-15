Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbWHORw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWHORw3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWHORw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:52:29 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50569 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030346AbWHORw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:52:28 -0400
Subject: Re: What determines which interrupts are shared under Linux?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roger Heflin <rheflin@atipa.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
In-Reply-To: <44E208AD.8060505@atipa.com>
References: <44E1D760.6070600@atipa.com>
	 <1155654379.24077.286.camel@localhost.localdomain>
	 <44E1E719.6020005@atipa.com>
	 <1155657316.24077.293.camel@localhost.localdomain>
	 <44E208AD.8060505@atipa.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Aug 2006 19:13:01 +0100
Message-Id: <1155665581.24077.302.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-15 am 12:47 -0500, ysgrifennodd Roger Heflin:
> On the specific kernel that I have I appear to have both IDE and
> sata_nv drivers, is there a way to force things to use sata_nv/libata
> rather than the older ide driver for the NVIDIA sata controller?

You can build 2.6.18-mm like that (say N to AMD/NVIDIA PATA driver, y to
sata_nv and pata_amd libata drivers). Still have to figure out why your
MPT fusion is slow but if its still slow in 2.6.18-mm then it needs
figuring out anyway

