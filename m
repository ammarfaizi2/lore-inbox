Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289517AbSAOMaM>; Tue, 15 Jan 2002 07:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289518AbSAOMaC>; Tue, 15 Jan 2002 07:30:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39951 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289517AbSAOM3l>; Tue, 15 Jan 2002 07:29:41 -0500
Subject: Re: Significant Slowdown Occuring in 2.2 starting with 19pre2
To: kern0201@siscom.net (Steve Sheftic)
Date: Tue, 15 Jan 2002 12:41:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200201150402.XAA08887@leros.siscom.net> from "Steve Sheftic" at Jan 14, 2002 11:02:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QSuJ-0004y1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've tracked to 2.2.19pre2. I do backups to a SCSI magneto-optical disk.
> My /home backup creates a 700MB+ file (using BRU). When I was using
> 2.2.14, this took roughly a half hour. When I upgraded to 2.2.20, this

> 2.2.17     22  23  22   <--- notable improvement
> 2.2.18     34  40
> 2.2.19p1   30  44
> 2.2.19p2  161 165       <--- 4x to 5x longer

The only change in 2.2.19pre2 is the merge of Andrea Arcangeli's VM. Please
talk to Andrea and see if he can work out why

Alan
