Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267324AbUHDP6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUHDP6K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 11:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267327AbUHDP6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 11:58:09 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:5781 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267324AbUHDP6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 11:58:02 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Wed, 4 Aug 2004 08:56:00 -0700
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
References: <20040804060840.54760.qmail@web14923.mail.yahoo.com>
In-Reply-To: <20040804060840.54760.qmail@web14923.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408040856.00911.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 3, 2004 11:08 pm, Jon Smirl wrote:
> This is a new version of Jesse's PCI ROM patch.
>
> It can read ROMs on x86. Main problem was that the PCI address space is
> not part of the kernel address space on the x86 so ioremap() is needed.
> I added the parts about assign/release resource but I am not sure that
> they are needed.

Ah, that would explain it.  Thanks for fixing it up.

Jesse
