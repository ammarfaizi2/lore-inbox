Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267189AbUBMSzd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267193AbUBMSzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:55:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:62088 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267189AbUBMSzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:55:31 -0500
Date: Fri, 13 Feb 2004 10:55:28 -0800
From: Chris Wright <chrisw@osdl.org>
To: Bas Mevissen <ml@basmevissen.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shut up about the damn modules already...
Message-ID: <20040213105528.E14506@build.pdx.osdl.net>
References: <20040212031631.69CAD2C04B@lists.samba.org> <402D0083.7010606@basmevissen.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <402D0083.7010606@basmevissen.nl>; from ml@basmevissen.nl on Fri, Feb 13, 2004 at 05:51:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[trimmed back Cc:]

* Bas Mevissen (ml@basmevissen.nl) wrote:
> I'm wondering why it is that the kernel is asking for non-existing 
> modules so often. Is it that userspace applications try to access all 
> kinds of devices too often (autoprobing) or it this (wanted) kernel 
> behaviour?

The most common and annoying example (the one Rusty used), "net-pf-10,"
is a result of a userspace app doing simple socket(AF_INET6,...).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
