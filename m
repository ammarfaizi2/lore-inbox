Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263310AbSJCPE2>; Thu, 3 Oct 2002 11:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263323AbSJCPEY>; Thu, 3 Oct 2002 11:04:24 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:64496 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263311AbSJCPEW>; Thu, 3 Oct 2002 11:04:22 -0400
Subject: Re: Linux 2.5.40-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D9C5827.70703@colorfullife.com>
References: <3D9C5827.70703@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 16:17:36 +0100
Message-Id: <1033658256.28814.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 15:45, Manfred Spraul wrote:
>  > o	Fix abuse of set_bit in winbond-840		(me)
> 
> Were there bug reports, Have you tested the change?

Yes and no - I don't have an 840

> I think the cpu_to_le32 is wrong.
> 
> On big endian computers, the nic is set into a big-endian mode, and it 
> did work with set_bit on my power mac. Unfortunately, I don't have 
> access to it right now.

The checks I did were that it seemed to produce the same data in both
cases. So if it was wrong before (using set_bit) its probably wrong now.

