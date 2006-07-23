Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWGWM3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWGWM3x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 08:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWGWM3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 08:29:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61635 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751199AbWGWM3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 08:29:52 -0400
Date: Sun, 23 Jul 2006 05:29:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: <deepti.chotai@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops in scsi_device_put after PCMCIA based USB HC is ejected
Message-Id: <20060723052950.52990f86.akpm@osdl.org>
In-Reply-To: <0F35D2C4458E9B4A9891BE2D4E0C8390013010B7@PNE-HJN-MBX01.wipro.com>
References: <0F35D2C4458E9B4A9891BE2D4E0C8390013010B7@PNE-HJN-MBX01.wipro.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jul 2006 15:17:02 +0530
<deepti.chotai@wipro.com> wrote:

> I am working on a HCD for an OHCI compliant USB Host Controller on a
> PCMICIA card for 2.6.15.4 kernel.

We've changed an awful lot of things in that area since 2.6.15.  It'd be
best if you could retest 2.6.18-rc2, please.
