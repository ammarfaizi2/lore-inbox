Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318501AbSIFKqf>; Fri, 6 Sep 2002 06:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318510AbSIFKqf>; Fri, 6 Sep 2002 06:46:35 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:2290 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318501AbSIFKqe>; Fri, 6 Sep 2002 06:46:34 -0400
Subject: Re: DMA borked in 2.4.20-pre5-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Joseph N.Hall" <joseph@5sigma.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020906012932Z318221-685+43270@vger.kernel.org>
References: <20020906012932Z318221-685+43270@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 06 Sep 2002 11:52:06 +0100
Message-Id: <1031309526.9861.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-06 at 02:36, Joseph N.Hall wrote:
> Okay, I got tired of living DMA hell with the Soyo Dragon Ultra 
> Platinum m/b (KT333a), and bought an ALi-based m/b instead,
> an IWill XP333-R.  But ... to my dismay I had no DMA at all
> when booting under 2.4.20-pre5-ac1, which at least gave me
> hard disk DMA on the Soyo.  Also under 2.4.20-pre5-ac1
> hdparm -d1 /dev/hda refused to work, and hdparm -X66 
> /dev/hda segfaulted:

All known problems. Your ALi should work just fine with a 2.4.19-ac
stable kernel release. 2.4.20pre-ac has lots of new and experimental IDE
work going on in it.

