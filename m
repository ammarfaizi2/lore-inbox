Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282595AbRKZWJD>; Mon, 26 Nov 2001 17:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282598AbRKZWIz>; Mon, 26 Nov 2001 17:08:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17927 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282595AbRKZWIr>; Mon, 26 Nov 2001 17:08:47 -0500
Subject: Re: Unresponiveness of 2.4.16
To: ngrennan@okcforum.org (Nathan G. Grennan)
Date: Mon, 26 Nov 2001 22:17:06 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1006812135.1420.0.camel@cygnusx-1.okcforum.org> from "Nathan G. Grennan" at Nov 26, 2001 04:02:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E168U3m-00077F-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.16 becomes very unresponsive for 30 seconds or so at a time during
> large unarchiving of tarballs, like tar -zxf mozilla-src.tar.gz. The
> file is about 36mb. I run top in one window, run free repeatedly in

This seems to be one of the small as yet unresolved problems with the newer
VM code in 2.4.16. I've not managed to prove its the VM or the differing
I/O scheduling rules however.

> Any ideas of how to fix this for 2.4.16?

If it is the VM then watch for a patch from Rik for 2.4.16 + RielVM. If
that helps then we know its VM related , if not then we know to look at
other suspects

Alan
