Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269581AbUJFXoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269581AbUJFXoh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269500AbUJFXlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:41:20 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:42156 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269581AbUJFXkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:40:55 -0400
Subject: Re: Probable module bug in linux-2.6.5-1.358
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097104833.26149.3.camel@localhost.localdomain>
References: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com>
	 <1097104833.26149.3.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097102295.29990.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 06 Oct 2004 23:38:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-07 at 00:20, Stephen Hemminger wrote:
> Oct  6 17:03:30 chaos kernel: Analogic Corp Datalink Driver : Module
> removed
> 
> The bug is in that driver. It needs to unregister the character device
> in it's module remove routine.  It doesn't appear to be in the main
> kernel source tree so bug Redhat or the vendor.

Not Red Hat shipped, appears to be his own code.

