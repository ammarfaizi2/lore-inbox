Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVCCQHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVCCQHh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 11:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVCCQHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 11:07:36 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:1994 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261869AbVCCQHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 11:07:24 -0500
Date: Thu, 3 Mar 2005 17:07:20 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: pci_find_class obsolete
In-Reply-To: <42271D12.90408@tiscali.de>
Message-ID: <Pine.LNX.4.61.0503031551460.1007@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0503031436490.22266@yvahk01.tjqt.qr>
 <42271D12.90408@tiscali.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> What function would I need to use, now that pci_find_class is gone?

> Hi!
> you have to use pci_get_class (). But have a look at the patches for 6111 
> on my webiste:

I use 4996 because it uses four times less kernel memory than 6111. (And on 
top, 6111 does not give me any performance improvements over 4996.)

> http://unixforge.org/~matthias-christian-ott/index.php?entry=entry050303-082233
What's the patch doing?

I do not use AGPGART/DRI - no performance plus either.



Jan Engelhardt
-- 
