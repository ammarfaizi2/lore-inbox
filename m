Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284314AbRL1XWs>; Fri, 28 Dec 2001 18:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284301AbRL1XWj>; Fri, 28 Dec 2001 18:22:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45837 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284285AbRL1XWb>; Fri, 28 Dec 2001 18:22:31 -0500
Subject: Re: 2.4.17 - HIMEM option creates unresolved symbols for FS modules
To: yknot@cipic.ucdavis.edu (Dennis Thompson)
Date: Fri, 28 Dec 2001 23:32:58 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4.3.1.2.20011228145143.00b8d7e0@phosphor.cipic.ucdavis.edu> from "Dennis Thompson" at Dec 28, 2001 03:09:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K6Uk-0002FN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I re-complied the kernel with only one change, High Memory Support was 
> turned off. The new kernel worked great and I had no unresolved symbols
> in any of the re-compiled modules.

If you change the memory support or uniprocessor/SMP you'll need to do a
totally clean rebuild
