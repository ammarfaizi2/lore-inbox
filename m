Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314484AbSELP0X>; Sun, 12 May 2002 11:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314545AbSELP0W>; Sun, 12 May 2002 11:26:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2822 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314484AbSELP0W>;
	Sun, 12 May 2002 11:26:22 -0400
Message-ID: <3CDE894D.6020002@mandrakesoft.com>
Date: Sun, 12 May 2002 11:25:01 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/00200203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: davej@suse.de, madkiss@madkiss.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Trivial bugfix in 3c509.c
In-Reply-To: <200205120116.DAA26360@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:

>Dave & Martin,
>
>I noticed you guys included Kasper Dupont's patch in your
>2.5.15 patch kits:
>
>>With 3c509 compiled in kernel calling ifup after lots of
>>diskaccess causes an Oops.
>>
>>read_eeprom was incorrectly marked as __init. This patch
>>applies against 2.4.19-pre8-ac1 and maybee also 2.4.19-pre8:
>>
>
>Note that 2.4.19-pre8-ac1 has a newer version of 3c509.c than
>either 2.4.19-pre8 vanilla or 2.5.15, and it's only the newer
>version that calls read_eeprom() from non-__init code.
>This patch is not needed for 2.5.15.
>
>(The only calls to read_eeprom() in 2.5.15 are from el3_probe(),
>which is __init.)
>

Nevertheless, I applied it to both, because I want to sync up both 
copies as much as possible.

    Jeff



