Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286803AbRLVPLH>; Sat, 22 Dec 2001 10:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286802AbRLVPKr>; Sat, 22 Dec 2001 10:10:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44042 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286801AbRLVPKp>; Sat, 22 Dec 2001 10:10:45 -0500
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.hel
To: dirk@staf.planetinternet.be (Dirk Moerenhout)
Date: Sat, 22 Dec 2001 15:20:48 +0000 (GMT)
Cc: jeffm@iglou.com (Jeff Mcadams), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112221538560.214-100000@dirk> from "Dirk Moerenhout" at Dec 22, 2001 04:03:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16HnxA-0004SS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> with bytes. Though it's not because bits make up bytes that bits are
> naturally forced to "live" on byte boundaries. As clock pulse generators
> generally don't really live on byte boundaries either there was never a
> real reason to make 1Mb/s related to bytes (or to make 1Kb/s related to
> bytes). When referring to byte-bound data transfer speed you can stick to
> xB/s instead of xb/s.

It gets worse the deeper you go. Over an HDLC based link for example
sequences of five one bits take longer to send due to bitstuffing. Any 
networking terminology is generally grossly simplified.
