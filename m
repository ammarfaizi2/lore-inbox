Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270013AbRHEVCb>; Sun, 5 Aug 2001 17:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270017AbRHEVCV>; Sun, 5 Aug 2001 17:02:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55565 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270013AbRHEVCK>; Sun, 5 Aug 2001 17:02:10 -0400
Subject: Re: Problems with 2.4.7-ac6 + SMP + FastTrak100
To: arnvid@karstad.org (Arnvid Karstad)
Date: Sun, 5 Aug 2001 22:04:12 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), arnvid@karstad.org (Arnvid Karstad),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010805224817.B859.ARNVID@karstad.org> from "Arnvid Karstad" at Aug 05, 2001 10:55:58 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15TV4G-0008Nd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried to both disable the pnpbios in the config but it didn't help
> 
> EIP 0010:[<c010c764>]
> Process swapper : (pid: 0, stackspace c0279000)
> CALLTRACE
> [<c01057c2>][<c0112d1e>][<c01051b0>][<c010501b0>][<c010524e>][<c0105000>][<c0105043>]
> 
> Can't really seem to find any of this in system.map .. but I'm prolly
> looking wrong =)

For each of the eip and call trace values find the System.map entry that is
the nearest address _before_ the one given

