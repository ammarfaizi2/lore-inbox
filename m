Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284253AbRLLA1u>; Tue, 11 Dec 2001 19:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284243AbRLLA1L>; Tue, 11 Dec 2001 19:27:11 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:36617 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284251AbRLLA0p>; Tue, 11 Dec 2001 19:26:45 -0500
Message-ID: <3C16A38E.7ED1230D@zip.com.au>
Date: Tue, 11 Dec 2001 16:23:42 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, Dan Maas <dmaas@dcine.com>,
        Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: IO degradation in 2.4.17-pre2 vs. 2.4.16
In-Reply-To: <Pine.LNX.4.21.0112111944330.26533-100000@freak.distro.conectiva> from "Marcelo Tosatti" at Dec 11, 2001 07:44:43 PM <E16Dw67-0007Hx-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > Time for CONFIG_OPTIMIZE_THROUGHPUT / CONFIG_OPTIMIZE_LATENCY ?
> > That would be the best thing to do, yes.
> 
> /proc/sys not CONFIG_..

/proc/sys/vm/bdflush, to be precise.

I thought we discussed all this?

-
