Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264475AbTDPQfz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbTDPQfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:35:40 -0400
Received: from mcomail01.maxtor.com ([134.6.76.15]:15626 "EHLO
	mcomail01.maxtor.com") by vger.kernel.org with ESMTP
	id S264475AbTDPQet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:34:49 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C102E0D12C@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@maxtor.com>
To: "'Pau Aliagas'" <linuxnow@newtral.org>,
       lkml <linux-kernel@vger.kernel.org>,
       "Mudama, Eric" <eric_mudama@Maxtor.com>
Cc: hps@intermeta.de
Subject: RE: [2.4.21-pre7-ac1] IDE Warning when booting
Date: Wed, 16 Apr 2003 10:45:34 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Pau Aliagas [mailto:linuxnow@newtral.org]
> Sent: Wednesday, April 16, 2003 10:40 AM
> To: lkml; Eric Mudama
> Cc: hps@intermeta.de
> Subject: RE: [2.4.21-pre7-ac1] IDE Warning when booting
> 
> # cat /etc/sysconfig/harddisks | grep -v "^#"
> USE_DMA=0 MULTIPLE_IO=16
> EIDE_32BIT=3
> LOOKAHEAD=1
> EXTRA_PARAMS="-u1"

For fun, try changing MULTIPLE_IO to 2 instead of 16, and see if the 0x5104
error still occurrs.

> How can I get this information?

At work I'd use a bus analyzer or something capable of issuing "raw" ATA
commands... however, from the /proc data that was posted, it appeared the
drive supported a maximum of 16 for its multi count, which should be fine.

That boggles me.

--eric
