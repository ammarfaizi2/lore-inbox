Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129507AbQK0Uy7>; Mon, 27 Nov 2000 15:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129520AbQK0Uyu>; Mon, 27 Nov 2000 15:54:50 -0500
Received: from mail1.rdc3.on.home.com ([24.2.9.40]:24290 "EHLO
        mail1.rdc3.on.home.com") by vger.kernel.org with ESMTP
        id <S129507AbQK0Uyi>; Mon, 27 Nov 2000 15:54:38 -0500
Message-ID: <003301c058b0$0875cc40$6400a8c0@wlfdle1.on.wave.home.com>
From: "John Zielinski" <grimr@home.com>
To: <linux-kernel@vger.kernel.org>
Subject: Anyone else kernel mounting a filesystem that has a block device?
Date: Mon, 27 Nov 2000 15:24:01 -0500
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to be mounting a filesystem that uses a block device from inside
the kernel.  This mount will not be visible from userland nor can it be
unmounted from userland.  Is anyone else doing something like this so we can
coordinate on the changes needed to fs/super.c?

John


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
