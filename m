Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317059AbSEXOaH>; Fri, 24 May 2002 10:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317120AbSEXOaG>; Fri, 24 May 2002 10:30:06 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:60905 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317059AbSEXOaF>; Fri, 24 May 2002 10:30:05 -0400
Date: Fri, 24 May 2002 16:29:39 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] New driver for Artop [Acard] controllers.
Message-ID: <Pine.SOL.4.30.0205241620440.16894-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a very quick look over patch/driver... looks quite ok...

But it doesn't support multiple controllers. We should add 'unsigned
long private' to 'ata_channel struct' and store index in the chipset
table there.
You can remove duplicate entries from module data table.

BTW: please don't touch pdc202xx.c I am playing with it...

greets
--
bkz

