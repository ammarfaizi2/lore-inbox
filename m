Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267131AbTCEPjM>; Wed, 5 Mar 2003 10:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267135AbTCEPjL>; Wed, 5 Mar 2003 10:39:11 -0500
Received: from terminus.zytor.com ([63.209.29.3]:59852 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S267131AbTCEPiV>; Wed, 5 Mar 2003 10:38:21 -0500
Message-ID: <3E661C56.5090503@zytor.com>
Date: Wed, 05 Mar 2003 07:48:38 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reserving physical memory at boot time
References: <Pine.LNX.3.95.1021204115837.29419B-100000@chaos.analogic.com>	<Pine.LNX.4.33L2.0212040905230.8842-100000@dragon.pdx.osdl.net>	<b442s0$pau$1@cesium.transmeta.com>	<32981.4.64.238.61.1046844111.squirrel@www.osdl.org>	<b453mj$qpi$1@cesium.transmeta.com> <20030305074327.673e2432.rddunlap@osdl.org>
In-Reply-To: <20030305074327.673e2432.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> | 
> | Unfortunately last time I commented on this the response was roughly
> | "well, the patch already made it into Linus' kernel, it's too late to
> | fix it now."  That isn't exactly a very helpful response.
> 
> I don't see why it's too late.  How can it be too late?
> Ah, because it's already made it into 2.4?
> 

More because people don't want to fix their mistakes, I suspect :(

I don't know who originally started adding stuff to "mem=", but I still 
feel it needs to be backed out and renamed.

> | The mem= parameter has the semantic in the i386/PC boot protocol that
> | it specifies the top address of the usable memory region that begins
> | at 0x100000.  It's a bit of a wart that the boot loaders have to be
> | aware of this, but it's so and it's been so for a very long time.
> 
> So it's the top of the 0x100000-mem physical linear memory region
> (i.e., no gaps)?

Correct.

