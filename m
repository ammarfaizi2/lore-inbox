Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286302AbRL0PYK>; Thu, 27 Dec 2001 10:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286300AbRL0PYB>; Thu, 27 Dec 2001 10:24:01 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:8966 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S286294AbRL0PXy>;
	Thu, 27 Dec 2001 10:23:54 -0500
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: =?iso-8859-1?Q?Ra=FAlN=FA=F1ez_de_Arenas___Coronado?= 
	<raul@viadomus.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: Out of Memory at 20GB of free memory ??
Date: Thu, 27 Dec 2001 07:23:55 -0800
Message-ID: <HBEHIIBBKKNOBLMPKCBBAEMAEEAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <E16JZGx-0000Lc-00@DervishD.viadomus.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of RaúlNúñez de
> Arenas Coronado
> Sent: Thursday, December 27, 2001 4:05 AM

> >/proc/meminfo after the first process kill:
> >        total:    used:    free:  shared: buffers:  cached:
> >Mem:  33815060480 13490249728 20324810752        0 15745024 13089452032
>
>     This leads to a suggestion... How about aligning the top
> indication with the numbers below (or even better, putting them in
> different lines ;)))
>
>     Even with more than 99MB of RAM (quite usual these days), the top
> line is misaligned and a little bit confusing.
>
>     I can make the necessary patch if anyone is interested.
>
>     Raúl

My impression was that the top few lines of /proc/meminfo were being "phased
out" in favor of the one-entry-per-line-in kB numbers below. If that is the
case (and assuming we don't want to change that to KiB or something of that
ilk :) perhaps what needs to change is not /proc/meminfo but "top".
--
M. Edward Borasky
znmeb@borasky-research.net
http://www.borasky-research.net

