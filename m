Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVGDPay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVGDPay (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 11:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVGDPax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 11:30:53 -0400
Received: from [212.76.81.218] ([212.76.81.218]:63492 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S261229AbVGDPaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 11:30:46 -0400
Message-Id: <200507041530.SAA02324@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>, <linux-ide@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [git patches] IDE update
Date: Mon, 4 Jul 2005 18:30:09 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <58cb370e05070405302d47fdfd@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcWAk7es3bA6Pg3KQhizDlwmtVZptQAGTDvQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote: {
What is the "int/dma problem"?
}

Hdparm -tT gives 38mb/s in 2.4.31
Cat /dev/hda > /dev/null gives 2% user 33% sys 65% idle

Hdparm -tT gives 28mb/s in 2.6.12
Cat /dev/hda > /dev/null gives 2% user 25% sys 0% idle 73% IOWAIT

It feels like DMA is not being applied properly in 2.6.12.

Your comments please.

Thanks!

