Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267415AbUIWVV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267415AbUIWVV7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267397AbUIWVVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:21:06 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:8572 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267378AbUIWVSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:18:52 -0400
Message-ID: <58cb370e040923141817412b43@mail.gmail.com>
Date: Thu, 23 Sep 2004 23:18:00 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Randy Gardner <lkml@bushytails.net>
Subject: Re: 2.6.8.1 OOM on hard drive copy
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4153384E.1030804@bushytails.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4153384E.1030804@bushytails.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004 13:55:42 -0700, Randy Gardner <lkml@bushytails.net> wrote:

> Quick system specs:
> Dual p3s on a MSI 694D Pro motherboard (via chipset), 2GB of ram.
> 2.6.8.1 kernel compiled with 4gb memory limit.

> The hard drive being copied from does not work with DMA, and having it
> in results in no dma for any of the drives.  (No message is displayed
> for this, but hdparm shows dma off when it's normally on.  On the box

It shouldn't be like that. Please send dmesg output for this system.

> the 8gb drive was removed from, dma would always immediately time out)

ditto
