Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261578AbTCTP75>; Thu, 20 Mar 2003 10:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261579AbTCTP75>; Thu, 20 Mar 2003 10:59:57 -0500
Received: from franka.aracnet.com ([216.99.193.44]:60634 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261578AbTCTP74>; Thu, 20 Mar 2003 10:59:56 -0500
Date: Thu, 20 Mar 2003 08:10:49 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Matthew Wilcox <willy@debian.org>
cc: linux-kernel@vger.kernel.org, jes@trained-monkey.org
Subject: Re: [PATCH] Fixup warning for acenic
Message-ID: <9240000.1048176648@[10.10.2.4]>
In-Reply-To: <20030320155943.GC14520@parcelfarce.linux.theplanet.co.uk>
References: <20030320151754.GB14520@parcelfarce.linux.theplanet.co.uk> <7000000.1048175453@[10.10.2.4]> <20030320155943.GC14520@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Please don't delete this table.  At some point when Jes gets his head
>> > out of the "must support Linux 1.2" space, this table will be used and
>> > then this driver will support hotplugging.
>> 
>> Fair enough ... but can we wrap it in CONFIG_SOMETHING? or #if 0 ?
> 
> If you must, you could wrap it in MODULE.  I don't see the value in
> removing every single warning from the kernel build.  If you're intent on

The main value is that it makes it a damned sight easier to catch *real*
errors and warnings.

> chasing all these pointless things, try installing gcc 3.3 and compiling
> a kernel with that.  It'll pump out more warnings than you can shake
> a pointy stick at.  Or turn on -W with gcc 2.96 -- it has much the
> same effect.  I made an effort to remove some of the -W warnings from
> the header files a while ago so I could compile individual files with
> -W as I find it tends to point out some mistakes I often make.

I refuse to use anything so much massively slower than 2.95, when it
produces worse code ;-) 3.3 might be better (I suppose) but is too 
experimental for my taste.

M.

