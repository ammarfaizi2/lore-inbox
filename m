Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266999AbSKWRpA>; Sat, 23 Nov 2002 12:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267019AbSKWRo7>; Sat, 23 Nov 2002 12:44:59 -0500
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:6461 "EHLO
	ubik.localnet") by vger.kernel.org with ESMTP id <S266999AbSKWRo7>;
	Sat, 23 Nov 2002 12:44:59 -0500
Message-ID: <3DDFC044.30701@murphy.dk>
Date: Sat, 23 Nov 2002 18:52:04 +0100
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: joakim.tjernlund@lumentis.se
Subject: Re: [PATCH 2.5] crc32 static initialization
References: <IGEFJKJNHJDCBKALBJLLEEEEFIAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joakim Tjernlund wrote:

>I have tested the new CRC32 patch on my big endian CPU(mpc860) in
>linux 2.4. Since the Makefiles look different in 2.4 vs. 2.5 I built and ran 
>gen_crctable.c manually, so I can not comment on the Makefile changes.
>
>Also, testing this in 2.4 makes it hard to generate a new 2.5 patch, so 
>I will just comment and send the whole file(se below)
>  
>
Thanks for the testing.

>Found this:
> 
>   crc32.c in crc32_be(): crc32table_le should be crc32table_be
>  
>
Can you send me a patch? I just used the original patch you sent me 
which uses
crc32table_le in crc32_be.

>   
>    Finally, I think the new local crc32.h should be renamed to crc32defs.h to
>    avoid confusion with the real linux/crc32.h.
>  
>
Possibly, all h files contain "defs".

/Brian

