Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268971AbRHYWC5>; Sat, 25 Aug 2001 18:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269238AbRHYWCs>; Sat, 25 Aug 2001 18:02:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16652 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268971AbRHYWCh>; Sat, 25 Aug 2001 18:02:37 -0400
Subject: Re: 2.4.8-ac11 compile error on sparc
To: gkade@unnerving.org (Gregory Ade)
Date: Sat, 25 Aug 2001 23:05:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108251424210.15717-100000@tigger.unnerving.org> from "Gregory Ade" at Aug 25, 2001 02:26:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15alYu-0008Hx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> trying to build 2.4.8-ac11 on my sparc, i get this:

You'll need to update the sparc tree to provide KM_USER0/USER1 - its part of 
the fixes for kmap blocking on high page clears

