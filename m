Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289231AbSAGPz0>; Mon, 7 Jan 2002 10:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289237AbSAGPzQ>; Mon, 7 Jan 2002 10:55:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24839 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289231AbSAGPzN>; Mon, 7 Jan 2002 10:55:13 -0500
Subject: Re: swapping,any updates ?? Just wasted money on mem upgrade performance still suck :-(
To: vda@port.imtp.ilyichevsk.odessa.ua
Date: Mon, 7 Jan 2002 16:06:19 +0000 (GMT)
Cc: cej@ti.com (christian e), riel@conectiva.com.br (Rik van Riel),
        andrea@suse.de (Andrea Arcangeli),
        linux-kernel@vger.kernel.org (linux kernel)
In-Reply-To: <200201071530.g07FU2E07077@Port.imtp.ilyichevsk.odessa.ua> from "vda@port.imtp.ilyichevsk.odessa.ua" at Jan 07, 2002 05:30:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16NcHz-0001dv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> knobs. It just won't happen. Fixing VM behavior is the only way. It has to 
> work satisfactorily _without_ tuning.

Thats something you will never achieve. Virtual memory is about heuristics,
crystal ball gazing and guesswork. There are always some workloads where you
want little caching and some where you want lots of caching - such as a 
fileserver.

You can make it right for most people but the last few percent you
will always get by tuning knobs - either directly or via GUI tools like
powertweak

Alan

