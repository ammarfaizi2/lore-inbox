Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVBGTcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVBGTcS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVBGTcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:32:17 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:15003 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261265AbVBGTb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:31:29 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Martins Krikis <mkrikis@yahoo.com>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
References: <1107701373.22680.115.camel@laptopd505.fenrus.org>
	<20050207182921.3015.qmail@web30206.mail.mud.yahoo.com>
	<bc8bcc5105020711081f1de175@mail.gmail.com>
From: Martins Krikis <mkrikis@yahoo.com>
In-Reply-To: <bc8bcc5105020711081f1de175@mail.gmail.com>
Date: 07 Feb 2005 14:30:47 -0500
Message-ID: <87d5vc9nh4.fsf_-_@yahoo.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martins Krikis <mkrikis@yahoo.com> writes:

> I do realize that Intel should have asked a long time ago for it
> to be considered for acceptance (I did ask back in October for
> 2.4.28).

Sorry about all the noise, but I just remembered some other important
aspects that played a role here.

Intel couldn't really ask for the inclusion of iswraid into the tree
much earlier than October because iswraid depends on either ata_piix
or ahci, both part of libata. Libata was included in 2.4.27, ata_piix
in 2.4.28, ahci in 2.4.29.

So I first asked for iswraid to be considered during 2.4.28-pre3 stage.
I was told that it's almost being released and that I should wait
for 2.4.29. There was also a discussion about whether it even belongs
or whether dm belongs more. With 2.4.29 I forgot to remind everybody
to look at iswraid and when I did it was too late for 2.4.29 and
Marcelo asked Jeff to review it for 2.4.30-pre1. (And thanks for
your support, Jeff.)

In short, I only first asked for it to be included with 2.4.28, but
I could not have done it earlier than that anyway because drivers it 
depends on weren't yet in 2.4.

  Martins Krikis
  Storage Components Division
  Intel Massachusetts

