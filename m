Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319166AbSHNBek>; Tue, 13 Aug 2002 21:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319170AbSHNBek>; Tue, 13 Aug 2002 21:34:40 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:10246 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S319166AbSHNBek>; Tue, 13 Aug 2002 21:34:40 -0400
Date: Tue, 13 Aug 2002 22:38:19 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Imran Badr <imran.badr@cavium.com>
cc: "'Ralf Baechle'" <ralf@linux-mips.org>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: RE: Cache coherency and snooping
In-Reply-To: <0aa401c2432e$04a95cc0$9e10a8c0@IMRANPC>
Message-ID: <Pine.LNX.4.44L.0208132237390.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2002, Imran Badr wrote:

> Please advise if following sequence of operations are going to help:
>
> alloc memory
> reserve the page
> flush every cache
> call ioremap_nocache

Won't work around hardware limitations.  If the hardware
cannot turn off caching, all you could do is flush the
page to ram before every explicit IO request...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

