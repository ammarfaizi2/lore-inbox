Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281285AbRKLGtG>; Mon, 12 Nov 2001 01:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281286AbRKLGs5>; Mon, 12 Nov 2001 01:48:57 -0500
Received: from david.siemens.de ([192.35.17.14]:47833 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id <S281285AbRKLGsn>;
	Mon, 12 Nov 2001 01:48:43 -0500
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: howarth@nitro.med.uc.edu
Cc: linux-kernel@vger.kernel.org, kernel@mandrakesoft.com
Subject: Re: ide-floppy.c vs devfs
Date: Mon, 12 Nov 2001 09:48:34 +0300
Message-ID: <001001c16b46$0cac8480$21c9ca95@mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3311
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The fix for it is included in current Mandrake cooker. As I already
said, I do not like it (the fix is to pretend we have media when we have
none) but it is the only possible way given current partition layer
design it seems.

I would prefer that partition layer registered .../disc for removable
media irrespectively of whether media is inserted or not, but well ...
it's up to other people to decide.

-andrej

Sorry, replying off web archive.
