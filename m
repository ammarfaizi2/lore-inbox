Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261867AbTCGXRg>; Fri, 7 Mar 2003 18:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261863AbTCGXRg>; Fri, 7 Mar 2003 18:17:36 -0500
Received: from mail2.fbab.net ([195.54.134.228]:44970 "HELO mail2.fbab.net")
	by vger.kernel.org with SMTP id <S261867AbTCGXRb>;
	Fri, 7 Mar 2003 18:17:31 -0500
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail2.fbab.net
X-Qmail-Scanner: 1.10 (Clear:0. Processed in 0.266271 secs)
Message-ID: <048901c2e501$569ef060$f80c0a0a@mnd>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
References: <DC900CF28D03B745B2859A0E084F044D043506DD@cceexc19.americas.cpqcorp.net> <3E5CE539.60905@pobox.com>
Subject: Re: lockups with 2.4.20 (tg3? net/core/dev.c|deliver_to_old_ones)
Date: Sat, 8 Mar 2003 00:29:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
> Rhodes, Tom wrote:
[snip]
>>
>> Until this is fixed, there are a couple work-arounds:
>
> It's fixed in tg3 version 1.4c, which is attached.  James Bourne also
> put up tg3 2.4.20 patches containing the needed fixes, at
> http://www.hardrock.org/kernel/2.4.20
>
> Jeff

I got an hang/oops with the tg3 driver aswell.
I just wanted to make sure that 1.4c+ fixes this bug too:

ftp://ftp.fbab.net/pub/mag/tg3_oops_small.jpg

I've still got it in KDB if you want to find anything out from that
(tell me what to do) ...
Before this hang i had a e1000 card that also stopped working after a
while, so i switched to tg3, and ofcourse i got a hang there too :)

Regards

Magnus

