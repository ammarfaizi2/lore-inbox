Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276945AbRJCTBT>; Wed, 3 Oct 2001 15:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276946AbRJCTA7>; Wed, 3 Oct 2001 15:00:59 -0400
Received: from hera.cwi.nl ([192.16.191.8]:55496 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S276945AbRJCTAy>;
	Wed, 3 Oct 2001 15:00:54 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 3 Oct 2001 19:01:10 GMT
Message-Id: <200110031901.TAA04080@vlet.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        linux-lvm@sistina.com, wichert@cistron.nl
Subject: Re: [linux-lvm] Re: partition table read incorrectly
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Other data point: the 2.2.19 kernel as found on the lnx bootable business
> card also gets it wrong and detect a sdb1..

But why do you call it wrong?
There is a partition table there, and a signature, and the
single entry describes (in DOS-type partition table style)
a partition with a length of 4GiB with System Id 0.

Some programs will call it an unused partition because of the
type 0, but there is a partition there.

Andries
