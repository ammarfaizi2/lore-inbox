Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVF1HuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVF1HuH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 03:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVF1Hqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 03:46:55 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:55001 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261860AbVF1HmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 03:42:23 -0400
In-Reply-To: <1119847159.5133.106.camel@gaston>
References: <1119847159.5133.106.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <931dc22c9709211c29f2d9d504d8ff9e@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] ppc32: Remove CONFIG_PMAC_PBOOK
Date: Tue, 28 Jun 2005 09:43:02 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.622)
X-MIMETrack: Itemize by SMTP Server on D12ML064/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 28/06/2005 09:42:17,
	Serialize by Router on D12ML064/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 28/06/2005 09:42:18,
	Serialize complete at 28/06/2005 09:42:18
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch removes CONFIG_PMAC_PBOOK (PowerBook support). This is now
> split into CONFIG_PMAC_MEDIABAY for the actual hotswap bay that some
> powerbooks have, CONFIG_PM for power management related code, and just
> left out of any CONFIG_* option for some generally useful stuff that 
> can
> be used on non-laptops as well.

Is there any real reason not to enable CONFIG_PM on all Macs?


Segher

