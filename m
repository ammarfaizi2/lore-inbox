Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWIIOpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWIIOpm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 10:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWIIOpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 10:45:41 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46002 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932233AbWIIOp3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 10:45:29 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, akpm@osdl.org, segher@kernel.crashing.org,
       davem@davemloft.net
In-Reply-To: <Pine.LNX.4.64.0609081928570.27779@g5.osdl.org>
References: <17666.8433.533221.866510@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0609081928570.27779@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Sep 2006 16:08:10 +0100
Message-Id: <1157814490.6877.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-08 am 19:42 -0700, ysgrifennodd Linus Torvalds:
> It shouldn't. It's too expensive. 

Well it does because way back when you said it should 8)

__writel/__readl were the ones allowed to be un-ordered.


