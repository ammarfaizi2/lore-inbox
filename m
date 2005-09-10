Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVIJNIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVIJNIv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 09:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVIJNIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 09:08:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12494 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750813AbVIJNIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 09:08:48 -0400
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
From: Arjan van de Ven <arjan@infradead.org>
To: luben_tulkov@adaptec.com
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <20050910041218.29183.qmail@web51612.mail.yahoo.com>
References: <20050910041218.29183.qmail@web51612.mail.yahoo.com>
Content-Type: text/plain
Date: Sat, 10 Sep 2005 15:08:33 +0200
Message-Id: <1126357713.3222.149.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No self respecting SAS chip would not do 64 bit DMA, or have an sg tablesize
> or any other limitation.

yet... there will be :)
> 
> Naturally, aic94xx has _no limitations_. :-)  But hey, our hardware just
> kicks a*s!

if it has no such limits then it indeed does!


> (Oh, I know, the solution you're paid to push into the kernel
> doesn't need those since it does all SAS in the firmware.)

I think you are way out of line here. James is very prudent in
separating his job at SteelEye and his maintainership.


> Hmm, lets see:
> I posted today, a _complete_ solution, 1000 years ahead of this
> "embryonic SAS class" you speak of.

yet you post this without having had ANY discussion or earlier reviews
in the recent months. IN fact to the outside world it looks like you sat
on this code for a long time for competative reasons and just posted it
now that Christoph is getting his layer finished.


> Furthermore, why do you want to use a downgrade solution?
> 
> The answer is simple:
>    After "emd", Dell (Hi Matt!) learned quickly that if they want something
> in SCSI Core, they have to hire the people who _make_the_decisions_ what
> goes in and stays out of SCSI Core, to write that something, irrespectively

well EMD's failure was 100% Adaptecs fault. Adaptec was warned EARLY ON
that a dmraid like solution was going to be needed. It was just that
Adaptec decided to ignore this advice (and focus only on 2.4 and ignore
2.6 entirely) that caused Adaptec to waste all the time and money on it.
 

> So as long as *you are on their payroll*, what are you discussing here

James is paid by SteelEye. Not by Dell or LSI.

> with me?  *You have an agenda*!

so do you.

> I long for the days of the previous maintainer.

What previous maintainer?


