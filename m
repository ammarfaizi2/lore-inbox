Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVAQVqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVAQVqS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 16:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVAQVqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:46:17 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:3466 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261455AbVAQVqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:46:00 -0500
Subject: Re: smbfs in 2.6.8 SMP kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brian Henning <brian@strutmasters.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41EC003B.7040606@strutmasters.com>
References: <41EBD4E8.70905@strutmasters.com>
	 <Pine.LNX.4.61.0501171633140.20155@jjulnx.backbone.dif.dk>
	 <41EC003B.7040606@strutmasters.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105984827.16096.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 17 Jan 2005 20:41:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-17 at 18:13, Brian Henning wrote:
> Jesper Juhl wrote:
> > If I remember correctly there was some smbfs breakage a few releases back 
> > - 2.6.8 sounds about right. I'd suggest you try a newer kernel like 2.6.10 
> > or 2.6.11-rc1 and see if that works better.
> 
> No luck with smbfs in 2.6.10 with SMP either; however, I discovered the 
> existence of CIFS (which I previously did not know about), and it 
> appears to work smoothly in place of smbfs.

2.6.10-ac fixes several problems with the later smbfs code but cifs is
probably the better choice

