Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289025AbSBDPgJ>; Mon, 4 Feb 2002 10:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289032AbSBDPf7>; Mon, 4 Feb 2002 10:35:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7187 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289025AbSBDPfs>; Mon, 4 Feb 2002 10:35:48 -0500
Subject: Re: O_DIRECT fails in some kernel and FS
To: lord@sgi.com (Steve Lord)
Date: Mon, 4 Feb 2002 15:46:20 +0000 (GMT)
Cc: cw@f00f.org (Chris Wedgwood), garzik@havoc.gtf.org (Jeff Garzik),
        mason@suse.com (Chris Mason), andrea@suse.de (Andrea Arcangeli),
        akpm@zip.com.au (Andrew Morton), gallir@uib.es (Ricardo Galli),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <1012835730.26397.519.camel@jen.americas.sgi.com> from "Steve Lord" at Feb 04, 2002 09:15:30 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16XlK0-0007Wu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If an application is multithreaded and is doing mmap and direct I/O
> from different threads without doing its own synchronization, then it
> is broken, there is no ordering guarantee provided by the kernel as
> to what happens first.

Providing we don't allow asynchronous I/O with O_DIRECT once asynchronous
I/O is merged.

Alan
