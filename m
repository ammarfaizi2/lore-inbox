Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVABPnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVABPnF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 10:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVABPmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 10:42:24 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:49837 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261262AbVABPlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 10:41:03 -0500
Subject: Re: why there is different kernel versions from RedHat?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux lover <linux_lover2004@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41D5FDCE.2090905@tmr.com>
References: <20041231133525.47475.qmail@web52205.mail.yahoo.com>
	 <41D5FDCE.2090905@tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104676568.14712.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 02 Jan 2005 14:37:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-01-01 at 01:33, Bill Davidsen wrote:
> linux lover wrote:
> > Hi all,
> > Where can i get special pathces used by RedHat to
> > original kernels from www.kernel.org?
> 
> Three step process
> 1 - get the RH source RPM and unpack
> 2 - get the kernel.org source of the same number
> 3 - use diff to generate the patch.
> 
> Optional step 4 - look at the size of it, shake your head and swear.

If you do it such a dumb way then sure. Most of the patches in the 2.6.8
and 2.6.9 ones are post 2.6.9 fixes already in the base tree because of
the lack of a stable base kernel tree in Linus new model.

In order that we don't go collectively insane maintaining it those are
broken out from the feature patches we needed. Generating a single giant
diff loses all the useful info.

Alan

