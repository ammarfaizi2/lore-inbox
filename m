Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbTDYWXO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 18:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbTDYWXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 18:23:14 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:21290 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S261281AbTDYWXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 18:23:13 -0400
Date: Fri, 25 Apr 2003 18:32:44 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re:  Re:  Swap Compression
To: linux-kernel@vger.kernel.org
Message-id: <200304251832440510.00D02649@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah you did but I'm going into a bit more detail, and with a very tight algorithm.  Heck the algo was originally designed based on another compression algorithm, but for a 6502 packer.  I aimed at speed, simplicity, and minimal RAM usage (hint:  it used 4k for the code AND the compressed data on a 6502, 336 bytes for code, and if I turn it into just a straight packer I can go under 200 bytes on the 6502).

Honestly, I just never looked.  I look in my kernel.  But still, the stuff I defined about swapon options, swap-on-ram, and how the compression works (yes, compressed without headers) is all the detail you need about it to go do it AFAIK.  Preplanning should be done there--done meaning workable, not "the absolute best."

--Bluefox Icy

---- ORIGINAL MESSAGE ----
List:     linux-kernel
Subject:  Re: Swap Compression
From:     John Bradford <john () grabjohn ! com>
Date:     2003-04-25 21:17:11
[Download message RAW]

> Sorry if this is HTML mailed.  I don't know how to control those settings

HTML mail is automatically filtered from LKML.

> COMPRESSED SWAP

We discussed this on the list quite recently, have a look at:

http://marc.theaimsgroup.com/?l=linux-kernel&m=105018674018129&w=2

and:

http://linuxcompressed.sourceforge.net/

John.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

