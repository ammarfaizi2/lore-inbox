Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTK3WqB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 17:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTK3WqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 17:46:01 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:3471 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261885AbTK3Wp7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 17:45:59 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Santiago Garcia Mantinan <lkml@manty.net>
Subject: Re: IDE DMA setting not available on 2.4.23 as a module
Date: Sun, 30 Nov 2003 23:47:16 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20031130195815.GA2409@man.beta.es> <200311302115.07898.bzolnier@elka.pw.edu.pl> <20031130224219.GA691@man.beta.es>
In-Reply-To: <20031130224219.GA691@man.beta.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311302347.16802.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please send dmesg and .config for this case (built-in Intel IDE driver).

thanks,
--bart

On Sunday 30 of November 2003 23:42, Santiago Garcia Mantinan wrote:
> > Do you have piix.o module loaded or PIIX support compiled-in?
>
> I had it compiled in, I didn't knew it could be compiled as a module, I
> have tried compiling it as a module and DMA works ok, however the module
> along with ide-core are not removable as piix says it is being used.
>
> I have compiled the kernel again with ide modular and piix compiled in,
> just in case I had not done it that way before and in fact I had done it
> that way and I have verified that I had done it like that, DMA doesn't work
> as PIIX driver is not used, I don't see any PIIX4 messages or any BM-DMA
> ones when doing it this way, that is the problem.
>
> Hope this clarifies things a little bit.
>
> If you need any other info/test, don't hesitate to contact.
>
> Regards...

