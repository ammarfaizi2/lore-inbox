Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269176AbRGaF2j>; Tue, 31 Jul 2001 01:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269178AbRGaF2a>; Tue, 31 Jul 2001 01:28:30 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:19356
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S269176AbRGaF2M>; Tue, 31 Jul 2001 01:28:12 -0400
Date: Mon, 30 Jul 2001 22:28:17 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@kobayashi.soze.net>
To: <Tony.Lill@ajlc.waterloo.on.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: laptops and journalling filesystems
In-Reply-To: <200107310254.WAA22236@spider.ajlc.waterloo.on.ca>
Message-ID: <Pine.LNX.4.33.0107302222000.8520-100000@kobayashi.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, Tony Lill wrote:

> Do any of the current batch of journalling filesystems NOT diddle the
> disk every 5 seconds? I've tried reiser and ext3 and they're both
> antithetic to spinning down the disk. Any plans to fix this bug in
> future kernels?

are you sure this is a product of the journal and not the vm?  a machine
with 1gig memory doing nothing (<25% physmem used) and ext2 has disk
accesses ever few minutes too.


justin

