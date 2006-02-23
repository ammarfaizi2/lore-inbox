Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWBWLA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWBWLA7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 06:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWBWLA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 06:00:59 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:64433 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751161AbWBWLA6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 06:00:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YAKH/wrIW7brwG+lz1Yjkwx8PC+Yp3hq9R0Rq/HSPS96CJlNOZ1LmUag6/1er/SuC834n7sv7aNI8RrgoOpFncdAi4Prf7MQZMBUftNVDtixjCm/3NFa5IyXsTs5JyXCzrFEC1lY9JVwKDzCEj0uPYTeILGsHyb95DXEEsoBdaI=
Message-ID: <7a37e95e0602230300r2b78f2d6ya4726e5d69342c98@mail.gmail.com>
Date: Thu, 23 Feb 2006 16:30:57 +0530
From: "Deven Balani" <devenbalani@gmail.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Subject: Re: non-PCI based libata-SATA driver
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Linux-arm-kernel@lists.arm.linux.org.uk
In-Reply-To: <43FD87A9.1010406@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7a37e95e0602220404y7b82104ch5c3cda087336aed7@mail.gmail.com>
	 <1140654191.8672.23.camel@localhost.localdomain>
	 <7a37e95e0602222208i9a7c973vc50ac336fb174024@mail.gmail.com>
	 <43FD87A9.1010406@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> non-PCI works quite easily under 2.6.x, because libata core uses the
> generic DMA mapping lib.  It's already confirmed to work on at least one
> other ARM embedded chipset (sorry can't give more detail).
Thanks a lot for the valuable info.

> 2.4.x is a lot of work to do non-PCI, largely because you have to deal
> with the lack of a generic DMA interface.  2.4.x libata is hardcoded to
> use PCI DMA mapping.
At the back of my mind, i'm still exploring on how much work will be
required to do non-PCI libata-SATA in 2.4.x.
{I mean the changes that need to be done in kernel-2.4.23 onwards to
support non-PCI libATA-SATA. By some means, I have access to
physically contiguous memory blocks which can be used to do
DMA-ScatterGather.}

A pointer from your side will help me in hitting the nail right,
otherwise I'll be hurting myself a lot later on :)

Thanks a lot once again.

Deven
