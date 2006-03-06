Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWCFTYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWCFTYt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWCFTYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:24:48 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:1492 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932351AbWCFTYs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:24:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fZDdCqz50MrZiKlormh5DOVjlKLiY/lamxiooKv5zOv49Wf2MsksGw58n7sI/d+SQ0GAUKolz50llrAcimtsO3gmS4NRijrn82UHlGVu710xvU/+01JpBoS+OEzPeA2NqSVay16Ml8sg1bNKslKXC4QM2fHZtUQyzS7e/Bud3Z4=
Message-ID: <41b516cb0603061124s3ab0aef2hf8ccc130f8e82c9b@mail.gmail.com>
Date: Mon, 6 Mar 2006 11:24:47 -0800
From: "Chris Leech" <chris.leech@gmail.com>
To: "Matthieu CASTET" <castet.matthieu@free.fr>
Subject: Re: [PATCH 0/8] Intel I/O Acceleration Technology (I/OAT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <pan.2006.03.05.16.14.19.327190@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0603041945520.29991@yvahk01.tjqt.qr>
	 <20060304.134144.122314124.davem@davemloft.net>
	 <200603041705.41990.gene.heskett@verizon.net>
	 <20060304.141643.04633220.davem@davemloft.net>
	 <pan.2006.03.05.16.14.19.327190@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But we need a special driver ?
> The IOAT driver from intel seems to expect a pci device (0x8086 0x1a38)
> and the common x86 computer have their dma in lpc/isa bridge.

It's really about bringing the concept of a generic DMA engine up to
date with modern system design in order to make it useful for I/O
offload.  This is a new descriptor programed memory copy engine that
shows up as a PCI Express device integrated into the MCH.

- Chris
