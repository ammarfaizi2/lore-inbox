Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUDSRP1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 13:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUDSRP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 13:15:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:57523 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261497AbUDSRPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 13:15:19 -0400
Date: Mon, 19 Apr 2004 10:09:41 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Subject: Re: [PATCH] floppy98.c: use kernel min/max
Message-Id: <20040419100941.5931dcc2.rddunlap@osdl.org>
In-Reply-To: <200404191859.29846.bzolnier@elka.pw.edu.pl>
References: <20040418194357.4cd02a06.rddunlap@osdl.org>
	<200404191414.15702.bzolnier@elka.pw.edu.pl>
	<20040419085116.1d8576a6.rddunlap@osdl.org>
	<200404191859.29846.bzolnier@elka.pw.edu.pl>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004 18:59:29 +0200 Bartlomiej Zolnierkiewicz wrote:

| On Monday 19 of April 2004 17:51, Randy.Dunlap wrote:
| > On Mon, 19 Apr 2004 14:14:15 +0200 Bartlomiej Zolnierkiewicz wrote:
| > | Hi Randy,
| > |
| > | I wonder if PC9800 fixes are worth the hassle as PC9800 merge
| > | (AFAIR first patch went into 2.5.50!) was never finished.
| > |
| > | I think somebody should fix it or we should just remove it completely.
| >
| > I agree -- completely, on all counts, and I'm trying to take that up
| > with Osamu Tomita, but he hasn't replied to my emails.
| 
| :-(
| 
| > BTW, I have fixes for about 95% of all of the PC-9800 modules
| > and can successfully build a PC-9800 kernel, with IDE, SCSI,
| 
| Cool, do you also have these patches?
| http://www.uwsg.iu.edu/hypermail/linux/kernel/0303.1/2045.html

I saw that, but I began with the latest linux98 tarball that I
could find at http://sourceforge.jp/projects/linux98/, for
2.5.67-bk9.  There are still lots of build issues with that
tarball, but I have most of them fixed.


| BTW at least PC9800 IDE support needs reworking - it is one BIG hack

Not a surprise.

| > speaker, etc.  However, I can't test it.  So I think that it is
| > fixable, but if it's been abandoned, it can also be removed.
| 
| Yep, somebody needs to maintain it or at least report when it breaks.

Yup.

--
~Randy
