Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVHBSev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVHBSev (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 14:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVHBSeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 14:34:50 -0400
Received: from [12.29.88.206] ([12.29.88.206]:30163 "EHLO quack.solace.net")
	by vger.kernel.org with ESMTP id S261581AbVHBSep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 14:34:45 -0400
Date: Tue, 2 Aug 2005 14:34:41 -0400
From: Nash <nash@solace.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12.3] drivers/pci: recognize more ICH7 PCI/SATA chips
Message-ID: <20050802183441.GD25843@quack.solace.net>
References: <20050802182842.GC25843@quack.solace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050802182842.GC25843@quack.solace.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Aug 02, 2005 at 02:28:42PM -0400, Nash wrote:
> 
> Updated pci/quirks.c to recognize additional ICH7 PCI/SATA controller
> chips such as those integrated on the ASUS P5WD2 Premium motherboard.
> 
> Signed-off-by: Nash E Foster <nash@solace.net>

Blergh, this is the correct ratch. How embarrassing.

Index: linux-2.6.12.3/drivers/pci/quirks.c
===================================================================
--- linux-2.6.12.3/drivers/pci/quirks.c 2005-07-15 17:18:57.000000000
-0400
+++ linux/drivers/pci/quirks.c  2005-07-26 22:32:09.000000000 -0400
@@ -1199,6 +1199,7 @@
        case 0x2680:    /* ESB2 */
                ich = 6;
                break;
+       case 0x27b8:
        case 0x27c0:
        case 0x27c4:
                ich = 7;

