Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbULNWXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbULNWXF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbULNWWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:22:40 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:43231 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261675AbULNWUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:20:32 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] fix ROM enable/disable in r128 and radeon fb drivers
Date: Tue, 14 Dec 2004 14:20:12 -0800
User-Agent: KMail/1.7.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200412141256.21143.jbarnes@engr.sgi.com> <9e4733910412141345380559da@mail.gmail.com>
In-Reply-To: <9e4733910412141345380559da@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412141420.12863.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, December 14, 2004 1:45 pm, Jon Smirl wrote:
> These drivers should be using the new ROM API in the PCI driver
> instead of manipulating the ROMs directly. Now that the ROM API is in
> the kernel all direct use of PCI_ENABLE_ROM should be removed. There
> are about thirty places in the kernel doing direct access. Kernel
> janitors would probably be a good place to track removing
> PCI_ENABLE_ROM.

Sure... but in the meantime the drivers should probably be trivially fixed 
like this so things don't break.

Thanks,
Jesse
