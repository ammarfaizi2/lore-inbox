Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWENPKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWENPKy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 11:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWENPKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 11:10:54 -0400
Received: from tim.rpsys.net ([194.106.48.114]:56546 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751443AbWENPKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 11:10:53 -0400
Subject: Re: MMC drivers for 2.6 collie
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060514145325.GA3205@elf.ucw.cz>
References: <20060514145325.GA3205@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 14 May 2006 16:10:40 +0100
Message-Id: <1147619440.5531.167.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-14 at 16:53 +0200, Pavel Machek wrote:
> I've tried searching sharp patches for MMC support, but could not find
> it. Or should MMC_ARMMMCI work on collie?

Sharp's 2.4 MMC/SD drivers were binary only for all Zaurus models. Since
we have documentation on the PXA, a 2.6 driver exists and works for all
PXA models as we could guess the power controls and GPIOs. Collie
(SA1100 based) used some kind of SPI interface through the LOCOMO chip
(as far as I know) which we have no documentation on.

-- 
Richard

