Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129832AbRBIHUT>; Fri, 9 Feb 2001 02:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129837AbRBIHUJ>; Fri, 9 Feb 2001 02:20:09 -0500
Received: from kauha.saunalahti.fi ([195.197.53.227]:36227 "EHLO
	kauha.saunalahti.fi") by vger.kernel.org with ESMTP
	id <S129832AbRBIHUD>; Fri, 9 Feb 2001 02:20:03 -0500
Message-ID: <000f01c09268$ee56e4a0$56dc10c3@tal.org>
From: "Kaj-Michael Lang" <milang@tal.org>
To: "Linux Kernel List" <linux-kernel@vger.kernel.org>
Subject: VIA Rhine on Alpha bug
Date: Fri, 9 Feb 2001 09:21:29 +0200
Organization: Tal.Org
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if it should work or not but using a VIA Rhine compatible card
on my LX164 locks it solid when transfering large packets:
ping -f host.on.100mbit.lan works
ping -f -s 1024 same.host locks it solid as does
untarring to a NFS mount.

No oops/panic, just locks solid.

Kaj-Michael Lang
milang@tal.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
