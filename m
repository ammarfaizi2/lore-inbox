Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271742AbRH1WvH>; Tue, 28 Aug 2001 18:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271738AbRH1Wu6>; Tue, 28 Aug 2001 18:50:58 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39172 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271752AbRH1Wuq>; Tue, 28 Aug 2001 18:50:46 -0400
Subject: Re: NIC driver: Newbie question
To: hacknet@cx979248-c.rsmt1.occa.home.com (kErNeL kRaCkEr)
Date: Tue, 28 Aug 2001 23:51:19 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01082815440601.00791@cx979248-c.rsmt1.occa.home.com> from "kErNeL kRaCkEr" at Aug 28, 2001 03:38:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15brhX-0006uY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a Network card driver newbie question.
> I am trying to learn how to use the NET_BH for developing a network card driver.
> 
> Under what circumstance(s) do you call mark_bh(NET_BH).

When you want the network stack to wake up and do stuff, so in Linux 2.2 
when you want it to call your hard_start_xmit with new buffers
