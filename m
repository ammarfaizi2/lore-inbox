Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbTIOXAI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 19:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbTIOXAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 19:00:08 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:49605 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id S261665AbTIOXAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 19:00:04 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200309152257.h8FMvDWc015485@wildsau.idv.uni.linz.at>
Subject: Re: usb-storage: how to ruin your hardware(?)
In-Reply-To: <20030909095711.GB19624@vasas.no-ip.org>
To: Peter Werner <The.Local.Hacker@vasas.no-ip.org>
Date: Tue, 16 Sep 2003 00:57:13 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


                                          But it's always possible to repair
> > such a drive with the vendor supplied formating utility, which is windows


by the way ... this is wrong. as it turned out later, it was not possible
to repair the usb-flashdisk-utility from the vendor. in w2k, it will
appears as "unknown security device" with a big yellow question mark.
so if you want to ruin your stick, proceed as follows:
 - fdisk /dev/sd?
 - go to expert menu
 - set numer of cyls twice as high
 - go back to normal menu
 - make partition of full size with new cyl.count

happy mke2fsing ;-)

after rebooting (machine will be in unusable state), the device wont be recognized
as usb-storage device. reason: the number of usb-endpoints suddenly dropped to 0 (zero).
I don't know if every stick acts this way .. but the Panram one does definitely.

all right then. end of thread ...
h.rosmanith


