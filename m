Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135463AbREGSM2>; Mon, 7 May 2001 14:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135489AbREGSMV>; Mon, 7 May 2001 14:12:21 -0400
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:47794 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S135463AbREGSMK>; Mon, 7 May 2001 14:12:10 -0400
Date: Mon, 7 May 2001 20:12:04 +0200 (CEST)
From: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
To: "Bene, Martin" <Martin.Bene@KPNQwest.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: what causes Machine Check exception? revisited (2.2.18)
In-Reply-To: <5F6171E541C8D311B9F200508B63D32801C31F52@ntexgvie01>
Message-Id: <Pine.LNX.4.31.0105072003210.8083-100000@phobos.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2001, Bene, Martin wrote:

[MCE caused by bad RAM]

> I don't think there is a way a machine check exception can be triggered by
> software - which it would have to be in order to be caused by bad RAMs.

A MCE is triggered by an ECC error - no software involved. A good trap
handler will then see if the error is recoverable (one-bit errors are),
notify userspace (so the admin gets mailed) and move the data out of this
page.

   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: DC26 EB8D 1F35 4F44 2934  7583 DBB6 F98D 9198 3292
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!

