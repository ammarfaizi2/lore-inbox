Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270155AbRIAGxP>; Sat, 1 Sep 2001 02:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270159AbRIAGxF>; Sat, 1 Sep 2001 02:53:05 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:4869
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S270155AbRIAGw4>; Sat, 1 Sep 2001 02:52:56 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200109010637.f816b6A28284@www.hockin.org>
Subject: Re: natsemi.c (linux 2.4.9) - Something Wicked happened! 18000
To: slug@aeminium.org (Nuno Miguel Fernandes Sucena Almeida)
Date: Fri, 31 Aug 2001 23:37:06 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0109010708370.19262-100000@aeminium.aeminium.pt> from "Nuno Miguel Fernandes Sucena Almeida" at Sep 01, 2001 07:45:34 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel: eth2: Setting full-duplex based on negotiated link capability.
> kernel: eth2: Something Wicked happened! 18000.
> 
> With tcpdump at the other computer i got all the echo send icmp packets
> but the NS NIC didn't seem to receive the echo reply packets!
> 
> I searched the linux kernel mailing list and found a post with this same
> error. Tried to override link negotiation with mii-diag but no luck.
> 
> They said that after an upgrade from 2.4.5 to 2.4.6 the error
> started to appear. So, i grabbed the natsemi.c source code from 2.4.5,
> compiled it and the system is now working fine, even with 100MbpsTx-FD,
> giving 10MByte/s.


aha!  So I'll check the diffs since 2.4.5 - thanks for the data point.  One
thing I did to make this error go away was increase the RX ring - I don't
have the code here, or I'd post a patch.  If you wait until tomorrow, I'll
pop into work and check out the diffs and post you an elementary patch, and
you can tell me if it goes away.

