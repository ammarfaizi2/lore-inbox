Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269228AbTCBPQM>; Sun, 2 Mar 2003 10:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269229AbTCBPQM>; Sun, 2 Mar 2003 10:16:12 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:54483 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S269228AbTCBPQK>;
	Sun, 2 Mar 2003 10:16:10 -0500
Message-ID: <3E6222A7.9030705@colorfullife.com>
Date: Sun, 02 Mar 2003 16:26:31 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce large stack usage
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd wrote:

> The twofish one is obviously
>broken, and I suspect huft_build/inflate_dynamic are the cause of the
>crashes I'm seeing during unpacking of initramfs.
>
What do you mean with broken? On i386, the function needs 32 byte stack 
+ the space for register saving.
It must be either a gcc bug, or a bug in your detection script - I don't 
see anything special in twofish_setkey.

--
    Manfred

