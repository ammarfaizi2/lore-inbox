Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282446AbRKZTwb>; Mon, 26 Nov 2001 14:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282430AbRKZTwO>; Mon, 26 Nov 2001 14:52:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45317 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282459AbRKZTvZ>; Mon, 26 Nov 2001 14:51:25 -0500
Subject: Re: EINTR vs ERESTARTSYS, ERESTARTSYS not defined
To: phil-linux-kernel@ipal.net (Phil Howard)
Date: Mon, 26 Nov 2001 19:59:40 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011122083623.A18057@vega.ipal.net> from "Phil Howard" at Nov 22, 2001 08:36:23 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E168Rum-0006Za-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In user space I have to define __KERNEL__ to get programs to compile
> when coded to know about all possible (valid?) values of errno from
> system calls.  As seen from strace:

Beware of strace data. Record the actual syscall returns in your program.
strace sees restarts, your app doesnt
