Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268140AbRHAUhl>; Wed, 1 Aug 2001 16:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268145AbRHAUhX>; Wed, 1 Aug 2001 16:37:23 -0400
Received: from www.edcom.no ([194.248.172.30]:20749 "EHLO edcom.no")
	by vger.kernel.org with ESMTP id <S268140AbRHAUhM>;
	Wed, 1 Aug 2001 16:37:12 -0400
From: "Svein Erling Seldal" <Svein.Seldal@edcom.no>
To: <linux-kernel@vger.kernel.org>
Subject: readw() access
Date: Wed, 1 Aug 2001 22:33:44 +0200
Message-ID: <NEBBLKFNEDOFBCDCJMLKCEAKCEAA.Svein.Seldal@edcom.no>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'm trying to port a driver from 2.2.x to 2.4.x where I previously has used
readw() to read the contents of the memory-adresses 0x408-0x40c (Where the
BIOS gives you the adr. for the par-ports.) But on 2.4.x readw(0x408) Oops:

"Unable to handle kernel NULL pointer dereference at virtual address
00000408"

How do you read a memory-address like this?


Svein Erling Seldal

