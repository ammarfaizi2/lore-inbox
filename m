Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289013AbSAOLgS>; Tue, 15 Jan 2002 06:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289038AbSAOLf7>; Tue, 15 Jan 2002 06:35:59 -0500
Received: from dark.pcgames.pl ([195.205.62.2]:43466 "EHLO dark.pcgames.pl")
	by vger.kernel.org with ESMTP id <S289013AbSAOLfw>;
	Tue, 15 Jan 2002 06:35:52 -0500
Date: Tue, 15 Jan 2002 12:35:33 +0100 (CET)
From: Krzysztof Oledzki <ole@ans.pl>
X-X-Sender: <ole@dark.pcgames.pl>
To: <linux-kernel@vger.kernel.org>
Subject: Re: ide.2.2.21.05042001-Ole.patch.gz
In-Reply-To: <Pine.LNX.4.33.0201112043340.14442-100000@dark.pcgames.pl>
Message-ID: <Pine.LNX.4.33.0201151226350.21809-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have just made ide.2.2.21.01152002-Ole patch:

o       backport from ide.2.4.16.12102001.patch: pdc202xx.c - ver 0.30
                - no 48-bit lba - this requires changes in other files:
                   ide-disk.c, ide.c, ide.h, ... Maybe in future...
o       fix missing DEVID_MR_IDE definition in ide-pci.c for VIA_82C576_1
o       add PROMISE_20268R, PROMISE_20269, PROMISE_20275 in ide-pci.c
o       add CONFIG_PDC202XX_FORCE option into Config.in, ide-pci.c

BTW: why the pdc202xx.c file still has "Version 0.30    Mar. 18, 2000"?
It has been changed since that time! :)

After all this changes, pdc202xx.c driver still works for my PDC20265 :)
So, if there is no problem with ide.2.4.16.12102001 my patch should also
works, maybe even for 20268R, 20269 and 20275 chipsets. ;-)

Best regards,

				Krzysztof Oledzki

