Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266933AbTAZOfH>; Sun, 26 Jan 2003 09:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266940AbTAZOfH>; Sun, 26 Jan 2003 09:35:07 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:22447 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S266933AbTAZOfG>;
	Sun, 26 Jan 2003 09:35:06 -0500
Date: Sun, 26 Jan 2003 15:40:31 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301261440.PAA08520@harpo.it.uu.se>
To: davidsen@tmr.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.5.59 Same problems as 55..58
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jan 2003 18:26:29 -0500 (EST), Bill Davidsen wrote:
>WARNING: /lib/modules/2.5.59/kernel/drivers/net/8390.ko needs unknown symbol crc32_le
>WARNING: /lib/modules/2.5.59/kernel/drivers/net/8390.ko needs unknown symbol bitreverse
>  .
>  . And this problem I've noted since 2.5.55

If your module-init-tools are older than 0.9.8, then this message
is expected. depmod doesn't find GPL only symbols. Fixed in 0.9.8.

/Mikael
