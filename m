Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUBESaP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 13:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUBESaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 13:30:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:39560 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266505AbUBESaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 13:30:09 -0500
X-Authenticated: #4512188
Message-ID: <40228BB0.9020606@gmx.de>
Date: Thu, 05 Feb 2004 19:30:08 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jaroslav Kysela <perex@suse.cz>
CC: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA 1.0.2c
References: <Pine.LNX.4.58.0402051838460.1864@pnote.perex-int.cz>
In-Reply-To: <Pine.LNX.4.58.0402051838460.1864@pnote.perex-int.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav Kysela wrote:
> Linus, please do a
> 
>   bk pull http://linux-sound.bkbits.net/linux-sound
> 
> The GNU patch is available at:
> 
>   ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2004-02-05.patch.gz

Doesn't build for me:

   LD      sound/parisc/built-in.o
   CC      sound/pci/intel8x0.o
sound/pci/intel8x0.c: In function `alsa_card_intel8x0_setup':
sound/pci/intel8x0.c:2817: error: Syntaxfehler before "get_option"
sound/pci/intel8x0.c:2824: error: Syntaxfehler before ')' token
make[2]: *** [sound/pci/intel8x0.o] Fehler 1
make[1]: *** [sound/pci] Fehler 2
make: *** [sound] Fehler 2

Prakash
