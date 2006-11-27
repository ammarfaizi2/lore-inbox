Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758177AbWK0OYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758177AbWK0OYx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 09:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758229AbWK0OYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 09:24:53 -0500
Received: from inetc.connecttech.com ([64.7.140.42]:39689 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id S1758177AbWK0OYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 09:24:52 -0500
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
       "'Alan'" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>,
       "'Linux ARM Kernel list'" <linux-arm-kernel@lists.arm.linux.org.uk>,
       <kernel-discuss@handhelds.org>
Subject: RE: tty line discipline driver advice sought, to do a 1-byte header and 2-byte CRC checksum on GSM data
Date: Mon, 27 Nov 2006 09:23:23 -0500
Organization: Connect Tech Inc.
Message-ID: <06e401c7122f$98acc1d0$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20061126030901.GB5207@lkcl.net>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: On Behalf Of Luke Kenneth Casson Leighton
> Subject: Re: tty line discipline driver advice sought, to do 
> a 1-byte header and 2-byte CRC checksum on GSM data

drivers/char/n_tty.c
include/linux/tty_ldisc.h
include/linux/tty_flip.h
include/linux/tty.h

I can't see a reason why your code shouldn't be a perfect fit as an
ldisc.

..Stu

