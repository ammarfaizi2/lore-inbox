Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVDDUOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVDDUOI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 16:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVDDUMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:12:53 -0400
Received: from smtp05.auna.com ([62.81.186.15]:46031 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S261366AbVDDUHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:07:45 -0400
Message-ID: <42519E82.50600@latinsud.com>
Date: Mon, 04 Apr 2005 22:07:30 +0200
From: "SuD (Alex)" <sud@latinsud.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: herbert@gondor.apana.org.au
Subject: Re: Oops in i810_audio (reply to herbert)
References: <424F20F6.8010804@latinsud.com> <424FC409.3020808@funkmunch.net> <42507F12.6070009@latinsud.com>
In-Reply-To: <42507F12.6070009@latinsud.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I already tried my own version of the patch with a few printk. I can 
tell you that both probe functions in (ac97_codec.c:719) would report 
the device as modem.

/* Check for an AC97 1.0 soft modem (ID1) */
codec->codec_read(codec, AC97_RESET) returned 0xd3a 
...

/* Check for an AC97 2.x soft modem */ ...
codec->codec_read(codec, AC97_EXTENDED_MODEM_ID) returned 0x1

After that, i mentally applied your patch and appreciated no differences 
in behaviour.

PS: sorry for replying to the wrong email, i am not subscribed to the 
list yet.
