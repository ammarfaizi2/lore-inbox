Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWBPMyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWBPMyR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 07:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWBPMyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 07:54:17 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59266 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751084AbWBPMyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 07:54:16 -0500
Subject: Re: [BUG] kernel 2.6.15.4: soft lockup detected on CPU#0!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Charles-Edouard Ruault <ce@ruault.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43F44978.2050809@ruault.com>
References: <43EF8388.10202@ruault.com>
	 <20060215185120.6c35eca2.akpm@osdl.org>  <43F44978.2050809@ruault.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Feb 2006 12:57:30 +0000
Message-Id: <1140094650.28094.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-02-16 at 10:44 +0100, Charles-Edouard Ruault wrote:
> >From what i understand it will fix the problem only if the drive is in
> PIO mode, which is the case for  Folkert van Heusden, who reported the
> same BUG output.

Timeouts will cause PIO fallbacks as the driver tries to beat the device
back into sanity so it seems reasonable to expect the fix to work in
this case.

