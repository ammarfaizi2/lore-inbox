Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268067AbRHFMOP>; Mon, 6 Aug 2001 08:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268094AbRHFMOF>; Mon, 6 Aug 2001 08:14:05 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61712 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268067AbRHFMNt>; Mon, 6 Aug 2001 08:13:49 -0400
Subject: Re: 2.2.1x kernel memory "leaks"
To: jlewis@lewis.org
Date: Mon, 6 Aug 2001 13:15:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0108052337300.1854-100000@redhat1.mmaero.com> from "jlewis@lewis.org" at Aug 05, 2001 11:40:18 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15TjIR-0000qs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> memory, but the majority is still tied up by the kernel.  I haven't found
> much documentation on it, but I suspect the dentry_cache may be to blame.
> What's a reasonable size for the dentry_cache?

Probably < 100,000 entries on  256Mb box, certainly not 1.2 million.

What file systems are mailer ?
