Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSERL2b>; Sat, 18 May 2002 07:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312296AbSERL2a>; Sat, 18 May 2002 07:28:30 -0400
Received: from infa.abo.fi ([130.232.208.126]:26381 "EHLO infa.abo.fi")
	by vger.kernel.org with ESMTP id <S311710AbSERL23>;
	Sat, 18 May 2002 07:28:29 -0400
Date: Sat, 18 May 2002 14:28:12 +0300
From: Marcus Alanen <marcus@infa.abo.fi>
Message-Id: <200205181128.OAA26251@infa.abo.fi>
To: szepe@pinerecords.com, Russell King <rmk@arm.linux.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Subject: Re: Linux-2.5.16
In-Reply-To: <20020518095125.GC10134@louise.pinerecords.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > <nico@cam.org>
>> > 	o [ARM 1110/1: fixes to the ARM checksum code
>> Not quite perfect yet, but I'm not too bothered - that used to be
>> [ARM PATCH]
>Now if only we knew which of the scripts Linus used. :)
>
>Matthias, is this regexp broken in the recent version of the
>script too?

I guess it still is "$_ =~ s/\[?PATCH\]?\s*//i;", which means
that it still is broken. There certainly are several solutions,
what do people think of "s/\[?[^\]]*PATCH\]?\W*//i;" ?
(Maybe a ^ at the beginning?) 

Marcus

-- 
Marcus Alanen
maalanen@abo.fi
