Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbSKXOPx>; Sun, 24 Nov 2002 09:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261317AbSKXOPx>; Sun, 24 Nov 2002 09:15:53 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:60821 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261312AbSKXOPw> convert rfc822-to-8bit; Sun, 24 Nov 2002 09:15:52 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: NFS performance ...
Date: Sun, 24 Nov 2002 15:23:01 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: KELEMEN Peter <fuji@elte.hu>, Andrea Arcangeli <andrea@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211241521.09981.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> I have a very simple NFS setup over a siwtched 100Mbit/s network.
> client is Celeron 400MHz/256M RAM, using XFS
> server is dual Pentium Pro 200MHz/1G RAM, using XFS
> server is running Linux 2.4.19-pre8aa3.
>
> Network bandwith can be utilized, because ICMP flooding the
> server results in ~20000 kbit/s network traffic (as of
> iptraf), but NFS (v3,udp) write performance is unacceptably
> slow (around 300 KiB/sec), same results with the following
> kernels:
> Linux 2.4.18-WOLK3.1
> Linux 2.4.18-wolk3.7.1
> Linux 2.4.20-pre8aa2
> However, with 2.4.19-rmap14b-xfs the very same NFS
> performance tops out at 2.54 MiB/sec.  What's the catch?
I think Andrea and me have something in our kernels that may cause it. For me 
I don't know what that can be. I even have no idea what it can be :(

Andrea, you?

Peter, have you also tested v3 over tcp?

ciao, Marc


