Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267278AbTCEQlp>; Wed, 5 Mar 2003 11:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267284AbTCEQlo>; Wed, 5 Mar 2003 11:41:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10507 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267278AbTCEQln>; Wed, 5 Mar 2003 11:41:43 -0500
Message-ID: <3E662B2E.6080304@zytor.com>
Date: Wed, 05 Mar 2003 08:51:58 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: DervishD <raul@pleyades.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unable to boot a raw kernel image :??
References: <20021129132126.GA102@DervishD> <3DF08DD0.BA70DA62@gmx.de> <b453er$qo7$1@cesium.transmeta.com> <20030305161244.GB19439@DervishD>
In-Reply-To: <20030305161244.GB19439@DervishD>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
>     Hi Peter :)
> 
>  H. Peter Anvin dixit:
> 
>>That, and the 1 MB limitation, is the reason it either needs to get
>>nuked or get some massive surgery.  I am currently trying to get Linus
>>to accept a patch to put it out of its misery.
> 
>     Please, try to convince Marcello and Alan, too. The 2.4 branch
> will be a happier branch (well, assuming that the Linux kernel has
> feelings, of course) without the raw kernel image booting. Anyway, it
> doesn't seem to work for El Torito emulated floppies... I will be the
> first who cry for this ancient code, but I think now it doesn't make
> sense. Anyone uses floppies yet? Here in Spain a floppy is more
> expensive than a 80 min. CD...
> 

It doesn't work for anything but old legacy floppies.  I have already
sent the code to Alan for 2.5-ac and to Andi for x86-64 (where it has
already been integrated); if anyone wants to try to persuade Marcelo to
integrate it, be my guest, the current patch is at:

ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/nobootsect-2.5.63-bk7-1.diff

It's already enough work to keep this patch up to date and trying to get
Linus to take it.

	-hpa


