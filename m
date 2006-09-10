Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965285AbWIJGb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965285AbWIJGb0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 02:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965289AbWIJGb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 02:31:26 -0400
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:60687 "EHLO
	smtp-vbr14.xs4all.nl") by vger.kernel.org with ESMTP
	id S965285AbWIJGbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 02:31:25 -0400
Date: Sun, 10 Sep 2006 08:30:58 +0200
From: thunder7@xs4all.nl
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@osdl.org>, Jurriaan <thunder7@xs4all.nl>,
       linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       "Antonino A. Daplas" <adaplas@pol.net>
Subject: Re: 2.6.18-rc6-mm1
Message-ID: <20060910063058.GA9516@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20060908011317.6cb0495a.akpm@osdl.org> <20060908193041.GA18966@amd64.of.nowhere> <20060908124411.aa96fb7b.akpm@osdl.org> <20060909090449.GA16579@amd64.of.nowhere> <20060909083140.adfa878e.akpm@osdl.org> <20060910000245.e9df3fea.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910000245.e9df3fea.khali@linux-fr.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>
Date: Sun, Sep 10, 2006 at 12:02:45AM +0200
> Hi Andrew, Jurriaan, Antonino,
> 
> So my guess is that Jurriaan's graphics adapter is supported by the
> savagefb driver, but the driver doesn't create an i2c bus for it
> (either because the hardware doesn't have it, or we simply have no
> support.) Jurriaan, please confirm that your adapter is not one of
> Savage4, Savage2000, ProSavagePM, ProSavage8.

lspci calls it 'S3 Inc. SuperSavage IX/C SDR (rev 05)' 

> 
> If my analysis is correct, the following patch should fix the problem.
> It can probably be optimized/cleaned up, but I'll leave that to
> Antonino. Jurriaan, can you please apply this patch on top of
> 2.6.18-rc6-mm1 and report success or failure?

This patch fixes my problems, rc6-mm1 boots without problems even with
the savagefb driver builtin.

Thanks,
Jurriaan
-- 
Genius untempered by ethics is a deadly commodity.
	Iain Irvine - A Shadow on the Glass
Debian (Unstable) GNU/Linux 2.6.18-rc4-mm3 4423 bogomips load 0.04
