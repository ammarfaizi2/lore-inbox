Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263003AbSJGMRm>; Mon, 7 Oct 2002 08:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263004AbSJGMRm>; Mon, 7 Oct 2002 08:17:42 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:42245 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S263003AbSJGMRl>;
	Mon, 7 Oct 2002 08:17:41 -0400
Date: Mon, 07 Oct 2002 14:24:02 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: 2.4.20-pre8 swaps ide controller order on A7V266-E
To: sflory@rackable.com, linux-kernel@vger.kernel.org
Message-id: <3DA17CE2.219E4F43@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Flory (sflory@rackable.com) wrote :

> 
>   I'm not sure what the kernel issue is, but there is a simple work 
> around. Enable CONFIG_BLK_DEV_OFFBOARD (aka boot off-board chipsets 
> first) in the ide section. You can also produce the same effect via 

What is the meaning of the word "boot" here ?
As this is a kernel option, it comes into effect when the kernel is
already loaded, so the boot already happened and this option can have
no effect on it.
Confused ...


> ide=reverse on the kernel command line (or an append statement in lilo). 
>  This will reverse the order in which the chipsets are seen. 

regards,
david
