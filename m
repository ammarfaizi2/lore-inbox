Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbTIKSUk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 14:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbTIKSUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 14:20:40 -0400
Received: from outbound02.telus.net ([199.185.220.221]:63693 "EHLO
	priv-edtnes10-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id S261433AbTIKSUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 14:20:38 -0400
Message-ID: <001601c37891$660cc5d0$5d74ad8e@hyperwolf>
From: "Eric Bickle" <ebickle@healthspace.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Problem: IDE data corruption with VIA chipsets on2.4.20-19.8+others
Date: Thu, 11 Sep 2003 11:20:36 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > kernel: hdc: dma_intr: error=0x40 { UncorrectableError },
LBAsect=150637065,
> > sector=150636992
>
> This is a physical failure from the hard disk *NOT* a Linux problem

That's exactially what I thought when I first saw the problem as well.

However, we had about 16-20 different drives show up with the problem, about
3 different brands too. I did some low-level tests on the drives that linux
had an error on and none of my diagnostic tools could find any problems.

Any ideas?

Thanks.
-Eric Bickle

