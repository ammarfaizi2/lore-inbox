Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284729AbRLJVgB>; Mon, 10 Dec 2001 16:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286403AbRLJVfG>; Mon, 10 Dec 2001 16:35:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57613 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286394AbRLJVdh>; Mon, 10 Dec 2001 16:33:37 -0500
Subject: Re: mm question
To: volodya@mindspring.com
Date: Mon, 10 Dec 2001 21:42:50 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), riel@conectiva.com.br (Rik van Riel),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0112101623110.18429-100000@node2.localnet.net> from "volodya@mindspring.com" at Dec 10, 2001 04:27:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DYCI-0003Zn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Right, but instead of trying to balance cache available memory and swap
> my swapper will only be concerned whether the page can be evicted and
> whether it is from the address range I want.

You want to rewrite the entire vm to have back pointers ? Right now you
can't find pages in an address range. Its all driven from the virtual side
without reverse lookup tables.

