Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265166AbRGGQLt>; Sat, 7 Jul 2001 12:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265193AbRGGQLj>; Sat, 7 Jul 2001 12:11:39 -0400
Received: from phnx1-blk2-hfc-0251-d1db10f1.rdc1.az.coxatwork.com ([209.219.16.241]:43175
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S265166AbRGGQL2>; Sat, 7 Jul 2001 12:11:28 -0400
Message-ID: <009601c106ff$a3cb2070$6baaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "Ryan Mack" <rmack@mackman.net>, <max_mk@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107070058350.29490-100000@mackman.net>
Subject: Re: [BUG?] vtund broken by tun driver changes in 2.4.6
Date: Sat, 7 Jul 2001 09:12:37 -0700
Organization: LSG, Inc.
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

Recompile your VTUND daemon with the new kernel headers (and also updated to
2.5 vtund, it has some small patches) and you will be fine.

----- Original Message -----
From: "Ryan Mack" <rmack@mackman.net>
To: <max_mk@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, July 07, 2001 1:02 AM
Subject: [BUG?] vtund broken by tun driver changes in 2.4.6


> I recently upgraded a server running vtund 2.4 (4/18/01) to stock 2.4.6
> kernel.  It seems the changes to the tun driver have broken vtund.  Now my
> syslog gets filled with the following messages when a client attempts to
> connect:
>
> Jul  5 10:15:53 mackman vtund[4011]: Session
> mackman-vpn[64.169.117.25:2359] opened
> Jul  5 10:15:53 mackman vtund[4011]: Can't allocate tun device. File
> descriptor in bad state(77)
> Jul  5 10:15:53 mackman vtund[4011]: Session mackman-vpn closed
> Jul  5 10:16:04 mackman vtund[4014]: Session
> mackman-vpn[64.169.117.25:2360] opened
> Jul  5 10:16:04 mackman vtund[4014]: Can't allocate tun device. File
> descriptor in bad state(77)
> Jul  5 10:16:04 mackman vtund[4014]: Session mackman-vpn closed
>
> Eventually the client gives up.  Do you have any suggestions or know of
> any fixes?
>
> Thanks, Ryan Mack
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>

