Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267425AbTB1C3v>; Thu, 27 Feb 2003 21:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267427AbTB1C3v>; Thu, 27 Feb 2003 21:29:51 -0500
Received: from d174.dhcp212-198-223.noos.fr ([212.198.223.174]:35003 "EHLO
	picsou.chatons") by vger.kernel.org with ESMTP id <S267425AbTB1C3u>;
	Thu, 27 Feb 2003 21:29:50 -0500
Message-ID: <3E5ECC05.6000209@ens.fr>
Date: Fri, 28 Feb 2003 03:40:05 +0100
From: David Monniaux <David.Monniaux@ens.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: fr, fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Asus P4S8X - SiS 7012 audio with C-Media 9739 codec
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a SiS 648-based motherboard (Asus P4S8X) with a SiS 7012 AC'97 
audio coupled with a C-Media 9739 codec (id 0x434D4961).

For some reason, mixer settings under Linux work in a binary fashion: 
either mute, or full volume, but no gradation.

I've fixed ac97_codec.c so that it detects the codec, but then I'm 
stuck. I got the 9739 technical documentation from C-Media's site, but 
it does not help much - it seems that the values put in the registers 
are all right.

I suspect some bypass mechanism or some bit that turns analog mixing 
off, but I don't see anything in the documentation about it.

Would somebody with the same motherboard care to do some experiments? 
Playing a sample with xmms, one can set volume to "mute", any other 
value gives a constant volume.

It's also impossible to record anything - the recording is blank.

Regards,
D. Monniaux

