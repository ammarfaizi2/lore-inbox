Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318026AbSHZJso>; Mon, 26 Aug 2002 05:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318027AbSHZJso>; Mon, 26 Aug 2002 05:48:44 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:5371 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318026AbSHZJsn>; Mon, 26 Aug 2002 05:48:43 -0400
Subject: Re: [BUG] initrd >24MB corruption
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Chua <jchua@fedex.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208261621190.2610-100000@boston.corp.fedex.com>
References: <Pine.LNX.4.44.0208261621190.2610-100000@boston.corp.fedex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 26 Aug 2002 10:54:16 +0100
Message-Id: <1030355656.16618.32.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 09:34, Jeff Chua wrote:
> 
> I posted a similar message last week. No response, but that was on
> Gcc3.2, but when I tried out on gcc2.95.3, it failed too.
> 
> Symptons:
> 	create 28MB ramdisk, fill up to 18MB, system boots ok.
> 
> 	create 28MB ramdisk, fill up to 24MB, system can't boot, fail at
> 
> 	RAMDISK: Compressed image found at block 0 ... then stuck!
> 
> 
> What's the next step to debug this?

Force a 1K block size when you make the fs

