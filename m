Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTESTvO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 15:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbTESTvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 15:51:14 -0400
Received: from [65.198.37.67] ([65.198.37.67]:2204 "EHLO gghcwest.com")
	by vger.kernel.org with ESMTP id S263131AbTESTvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 15:51:13 -0400
Subject: RE: HD DMA disabled in 2.4.21-rc2, works fine in 2.4.20
From: "Jeffrey W. Baker" <jwbaker@acm.org>
To: "Mudama, Eric" <eric_mudama@maxtor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <785F348679A4D5119A0C009027DE33C102E0D3AB@mcoexc04.mlm.maxtor.com>
References: <785F348679A4D5119A0C009027DE33C102E0D3AB@mcoexc04.mlm.maxtor.com>
Content-Type: text/plain
Message-Id: <1053374646.10240.5.camel@heat>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 19 May 2003 13:04:06 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-19 at 12:56, Mudama, Eric wrote:
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> 
> I think that is the offending line?
> 
> can you enable DMA transfer modes on the drive using hdparm?

Why should force be enabled?  Forced sounds like a last resort.  If you
read this thread you will see that hdparm isn't working.  It returns
EPERM.

I was using Via IDE chipset and, yes, I had configured the kernel for
VIA support.  That's why it worked in 2.4.20.  But it stopped working in
2.4.21-rc.

Meanwhile, I have switched to 2.4.21-rc-ac, and dumped the hardware in
favor of Intel i865, and DMA is working again.

-jwb

