Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130172AbRAXIsR>; Wed, 24 Jan 2001 03:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130329AbRAXIsI>; Wed, 24 Jan 2001 03:48:08 -0500
Received: from oldftp.webmaster.com ([209.10.218.74]:55473 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S130172AbRAXIrz>; Wed, 24 Jan 2001 03:47:55 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Chris Wedgwood" <cw@f00f.org>,
        "Leslie Donaldson" <donaldlf@hermes.cs.rose-hulman.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Question: Memory change request
Date: Wed, 24 Jan 2001 00:47:53 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKIEPFNDAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010124210500.B7029@metastasis.f00f.org>
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> mprotect the page(s) you are interested in so you can't write to them
> and catch SEGV -- when someone attempts to write you can pull apart
> the stack frame mark the page(s) RO and continue.
> 
> if you are really stuck i think i have example code to do this
> somewhere for ia32 (stack frame is arch. dependent)

	I bet ElectricFence would serve as example code.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
