Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315225AbSEDWeS>; Sat, 4 May 2002 18:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315229AbSEDWeR>; Sat, 4 May 2002 18:34:17 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25606 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315225AbSEDWeR>; Sat, 4 May 2002 18:34:17 -0400
Subject: Re: IO stats in /proc/partitions
To: Andries.Brouwer@cwi.nl
Date: Sat, 4 May 2002 23:53:06 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, hpa@zytor.com, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
In-Reply-To: <UTC200205041959.g44JxQa20044.aeb@smtp.cwi.nl> from "Andries.Brouwer@cwi.nl" at May 04, 2002 09:59:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1748Oo-0000Ub-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Earlier I noticed that RedHat did put some statistics in
> /proc/partitions. That was bad, but I assumed that it was
> their laziness, being too busy to do a proper job.

It was put there in the 2.2 era after discussion with various folks. Its
been in most vendor kernels for about four years.

> On the other hand, disk statistics should not be in
> /proc/partitions. They should be in /proc/diskstatistics.
> I see a heading today "rio rmerge rsect ruse wio wmerge"
> "wsect wuse running use aveq". No doubt next year we'll
> want different statistics. So /proc/diskstatistics should
> start with a header line including a version field.

The stats have been unchanged for years too. As to version lines 
why ? This is lets mke /proc XML hell again

> Please keep these disk statistics apart from /proc/partitions.

It has to contain each partiiton anyway. 
