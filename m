Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263622AbTLONaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 08:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTLONaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 08:30:10 -0500
Received: from asclepius.uwa.edu.au ([130.95.128.56]:17537 "EHLO
	asclepius.uwa.edu.au") by vger.kernel.org with ESMTP
	id S263622AbTLONaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 08:30:06 -0500
Subject: Re: cdrecord hangs my computer
From: Paul Marinceu <elixxir@ucc.asn.au>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1071494967.2503.82.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 15 Dec 2003 21:29:27 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just thought I'd add some positive feedback to this thread, if a bit
late (and not really related to cdrecord).

I updated my laptop to -test11 a couple of hours ago and burnt my first
cd using ide-cd. Not having made (nor planning to make) any benchmarks,
the following is to be taken with a grain of salt:

I used a recent xcdroast with a Matshita (Panasonic) ATAPI CD-RW/DVD-ROM
combo drive (model UJDA740) and was impressed. It Just Worked (TM) and
performance was excellent (at 16x), barely using any cpu at all.

Although ide-scsi has been faithful to me, I'm glad that the legacy
emulated scsi code has finally been replaced in favour of native
ide/atapi. I don't really care whether it's dev=0,0,0 or dev=/dev/cdrom,
though from a HCI point of view, the latter is better, but I definitely
want to thank those responsible. I'm sure that a lot of effort has gone
into making this possible.

My laptop _doesn't have_ any scsi hardware, so why should I then have to
select the scsi tree in my kernel config?? Happily, no more.


-- 
 Paul Marinceu
 http://elixxir.ucc.asn.au


