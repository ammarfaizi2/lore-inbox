Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132777AbRDDJZs>; Wed, 4 Apr 2001 05:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132778AbRDDJZj>; Wed, 4 Apr 2001 05:25:39 -0400
Received: from agnus.shiny.it ([194.20.232.6]:5892 "EHLO agnus.shiny.it")
	by vger.kernel.org with ESMTP id <S132777AbRDDJZ3>;
	Wed, 4 Apr 2001 05:25:29 -0400
Message-ID: <XFMail.010404112422.pochini@shiny.it>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3ACA41D6.83718034@inter.nl.net>
Date: Wed, 04 Apr 2001 11:24:22 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Jurgen Kramer <GTM.Kramer@inter.nl.net>
Subject: RE: 2048 byte/sector problems with kernel 2.4
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I recently acquired a 1.3GB MO drive. When I use small (230MB and 540MB)
>
> MO disks which have normal 512 bytes/sector it all works flawlessly but
> as soon
> as a put in a 1.3GB disk which uses the 2048 bytes/sector format it all
> goes
> wrong. As soon as I write something to the disk by issuing a cp command
> the command
> just eats 99% CPU time and does not write a single byte to disk (it
> seems).

Hmm, I have no problems with 640MB disks with 2KB/sector (bot normal and
"overwrite" media). This  night I'll try with a 1.2GB disk. I'll let
you know.

> Is this a known problem ?

Only with FAT fs AFAIK. ext2 should work fine (or at least it works
fine for me since 2.1.153).

> I also tried it with 2.2.18 there it works but it seems to be utterly
> slow.

Yes, it's a request merging problem, fixed in 2.4.


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-

