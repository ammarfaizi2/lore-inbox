Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbTDWWzz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 18:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbTDWWzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 18:55:55 -0400
Received: from [12.47.58.232] ([12.47.58.232]:39088 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264284AbTDWWzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 18:55:54 -0400
Date: Wed, 23 Apr 2003 16:05:51 -0700
From: Andrew Morton <akpm@digeo.com>
To: cb-lkml@fish.zetnet.co.uk
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [2.5.68-mm2] [3c574_cs] irq 11: nobody cared
Message-Id: <20030423160551.30091419.akpm@digeo.com>
In-Reply-To: <20030423214955.GA602@fish.zetnet.co.uk>
References: <20030423214955.GA602@fish.zetnet.co.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Apr 2003 23:07:55.0097 (UTC) FILETIME=[2C42A490:01C309ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cb-lkml@fish.zetnet.co.uk wrote:
>
> 
> 2.5.68-mm2 gives the following message on ethernet activity. Network appears to
> work fine.
> 
> lspci -vvv output also follows.
> 

Zillions of net drivers (including 3c574_cs) have not yet been converted.

The mongo patch at

http://www.zip.com.au/~akpm/linux/patches/2.5/irqreturn-drivers-net.patch

should get most of them.


