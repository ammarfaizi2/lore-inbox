Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317822AbSFMUjs>; Thu, 13 Jun 2002 16:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317823AbSFMUjr>; Thu, 13 Jun 2002 16:39:47 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:53706 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S317822AbSFMUjo>;
	Thu, 13 Jun 2002 16:39:44 -0400
Date: Thu, 13 Jun 2002 22:39:22 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200206132039.WAA03650@harpo.it.uu.se>
To: nick@octet.spb.ru
Subject: Re: linux 2.4.19-preX IDE bugs
Cc: alan@lxorguk.ukuu.org.uk, andre@linux-ide.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2002 15:28:13 +0400, Nick Evgeniev wrote:
>Are you using it in SMP config?
>
>> >Agreed. But all what I see is that STABLE Linux kernel DOESN'T has
>working
>> >driver for promise controller (including latest ac patches) for SEVERAL
>> >MONTHS.
>>
>> I don't know what your problem with the Promise driver is, but
>> my experience is the opposite. I have never had any problems with
>> the 2.4 (or 2.2 + Andre's IDE patch) pdc202xx driver and my
>> Ultra100 (20267) card, which sits in a 24/7 News server and

No, UP (ASUS 440BX board).

Instead of blasting out "the driver doesn't work, remove it!" when
it obviously does work in many cases, you should investigate
(perhaps through a poll on LKML) which configurations work and
which ones do not. That may provide enough clues to identify and
hopefully fix the problem.

/Mikael
