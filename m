Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292909AbSB1FN1>; Thu, 28 Feb 2002 00:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293171AbSB1FLe>; Thu, 28 Feb 2002 00:11:34 -0500
Received: from rj.SGI.COM ([204.94.215.100]:49597 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S293170AbSB1FLQ>;
	Thu, 28 Feb 2002 00:11:16 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Benjamin Pharr <ben@benpharr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: .text problems in 2.5.6-pre1 
In-Reply-To: Your message of "Wed, 27 Feb 2002 22:34:41 MDT."
             <20020228043441.GA32149@hst000004380um.kincannon.olemiss.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Feb 2002 16:11:00 +1100
Message-ID: <13808.1014873060@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2002 22:34:41 -0600, 
Benjamin Pharr <ben@benpharr.com> wrote:
>I saw a couple of mentions in the changelog that the .text problem had
>been fixed in this version. However, I found this one while compiling:
>drivers/char/drm/drm.o: In function `i810_dma_initialize':
>drivers/char/drm/drm.o(.text+0x1dc19): undefined reference to `virt_to_bus_not_defined_use_pci_map'

That has nothing to do with the .text problem.  DRM is using an old PCI
API.

