Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265469AbRF1BGf>; Wed, 27 Jun 2001 21:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbRF1BG0>; Wed, 27 Jun 2001 21:06:26 -0400
Received: from hera.cwi.nl ([192.16.191.8]:27578 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S265469AbRF1BFQ>;
	Wed, 27 Jun 2001 21:05:16 -0400
Date: Thu, 28 Jun 2001 03:05:03 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106280105.DAA331227.aeb@vlet.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, andre@aslab.com
Subject: Re: Patch(2.4.5): Fix PCMCIA ATA/IDE freeze (w/ PCI add-in cards)
Cc: Gunther.Mayer@t-online.de, dhinds@zen.stanford.edu,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Andre Hedrick <andre@aslab.com>

    You know yourself first and all the screwed up ATAPI products that are
    still using SFF-8020 that has been obsoleted before I start maintaining
    the subsystem three plus years ago. 

Hi Andre -

Why precisely is complying to SFF-8020 broken?
That was the standard. The standard that Microsoft required.
Other people made a different standard, and claimed that theirs
was better or more official or whatever, but reality is that
the products were not manufactured following this so-called
better standard.
You are a good disciple of Hale, but it is no use ignoring the
fact that a very large number of devices was made following SFF-8020.
These devices are not necessarily screwed, they tend to work fine,
although both ATA and ATAPI devices have their quirks.

SFF-8020, later INF-8020, became part of ATA/ATAPI-4 (1998).
The T13 people that merged SFF-8020 and produced ATA/ATAPI-4
changed a few details about how a master is supposed to react
when a nonexistent slave is selected. Nobody really noticed,
and ATA/ATAPI-5 still had the same requirements. But then long
discussions about this difference caused ATA/ATAPI-6 to go back
to the original SFF-8020 requirements. Do you disagree with this
description of history? If you agree then it is not SFF-8020
but ATA/ATAPI-4 and ATA/ATAPI-5 that today must be considered broken
in this respect. I am referring to Section 9.16.1 of these standards.

Maybe there are other things in SFF-8020 that you consider broken?

Andries


