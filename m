Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264413AbRFOOSn>; Fri, 15 Jun 2001 10:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264414AbRFOOSd>; Fri, 15 Jun 2001 10:18:33 -0400
Received: from ip116.gte31.rb1.bel.nwlink.com ([207.202.209.116]:22047 "EHLO
	lily.altaserv.net") by vger.kernel.org with ESMTP
	id <S264413AbRFOOSN>; Fri, 15 Jun 2001 10:18:13 -0400
Date: Fri, 15 Jun 2001 07:17:54 -0700 (PDT)
From: <chuckw@altaserv.net>
X-X-Sender: <chuckw@localhost.localdomain>
To: Scott Laird <laird@internap.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.2.19 -> 80% Packet Loss 
In-Reply-To: <Pine.LNX.4.33.0106141636330.2642-100000@laird.ocp.internap.com>
Message-ID: <Pine.LNX.4.33.0106150711350.20189-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> You can fix this by upping the socket buffer that ping asks for (look
> for setsockopt( ... SO_RCVBUF ...)) and then tuning the kernel to
> allow larger socket buffers.  The file to fiddle with is
> /proc/sys/net/core/rmem_max.

Currently it is set to 65535. I doubled it several times and each time saw
no change when I sent it a ping flood with packet size 64590 or higher.
What sort of magnitude were you thinking?


> That doesn't really answer why you'd want to fling that many 64k-ish
> ping packets around, though.

No reason specifically other than intuition. Just kinda stumbled on to
this one.

-Chuck


-- 
Chuck Wolber
System Administrator
AltaServ Corporation
(425)576-1202
ten.vresatla@wkcuhc

Quidquid latine dictum sit, altum viditur.

