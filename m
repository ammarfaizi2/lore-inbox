Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbTDGX1x (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263753AbTDGX11 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:27:27 -0400
Received: from pop.gmx.de ([213.165.65.60]:61711 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263905AbTDGXSU (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 19:18:20 -0400
Message-ID: <3E9209E9.1040208@gmx.net>
Date: Tue, 08 Apr 2003 01:29:45 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH: clean up pci interrupt line whacking
References: <200304080015.h380Fc34009018@hraefn.swansea.linux.org.uk>
In-Reply-To: <200304080015.h380Fc34009018@hraefn.swansea.linux.org.uk>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/ide/pci/hpt366.c linux-2.5.67-ac1/drivers/ide/pci/hpt366.c
> --- linux-2.5.67/drivers/ide/pci/hpt366.c	2003-03-26 19:59:51.000000000 +0000
> +++ linux-2.5.67-ac1/drivers/ide/pci/hpt366.c	2003-04-06 23:03:51.000000000 +0100
> @@ -1106,13 +1106,10 @@
> [...]

> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/ide/pci/pdc202xx_new.c linux-2.5.67-ac1/drivers/ide/pci/pdc202xx_new.c
> --- linux-2.5.67/drivers/ide/pci/pdc202xx_new.c	2003-03-26 19:59:51.000000000 +0000
> +++ linux-2.5.67-ac1/drivers/ide/pci/pdc202xx_new.c	2003-04-06 23:04:50.000000000 +0100
> @@ -592,15 +592,8 @@
> [...]

Will this also go into 2.4.21?

Regards,
Carl-Daniel

