Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262164AbSJFT4D>; Sun, 6 Oct 2002 15:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262177AbSJFT4D>; Sun, 6 Oct 2002 15:56:03 -0400
Received: from mallaury.noc.nerim.net ([62.4.17.82]:2060 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id <S262164AbSJFT4C>; Sun, 6 Oct 2002 15:56:02 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.2] i386/dmi_scan updates
From: Jean Delvare <khali@linux-fr.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sun, 6 Oct 2002 22:03:18 CEST
Reply-To: Jean Delvare <khali@linux-fr.org>
X-Priority: 3 (Normal)
X-Originating-Ip: [172.181.74.109]
X-Mailer: Webmail Nerim (NOCC v0.9.5)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <20021006200137.8836C62DD7@mallaury.noc.nerim.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Our console doesn't handle arbitary 8bit encodings. There
> are japanese DMI strings out there for example
OK. Anyway, this is for debugging only and I don't intend to do it right now, if I ever do. I came up to a new patch that I still need to test. I'll be posting it tomorrow if it works as intended. It should solve everything we've been discussing about except ascii filtering.

> Oh as a PS btw don't worry about code size for the dmi
> scanner as it is all marked __init. The entire DMI code
> gets turned back into free memory by the end of the boot
> of the kernel, so you can put complex checks in there if
> it helps
I figured this out right after posting my message. I am really new to kernel code, as you see. I'll remember this, thanks.

Jean Delvare


___________________________________
Webmail Nerim, http://www.nerim.net/


