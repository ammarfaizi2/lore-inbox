Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSHGVJg>; Wed, 7 Aug 2002 17:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314083AbSHGVJg>; Wed, 7 Aug 2002 17:09:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:63724 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S313773AbSHGVJf>;
	Wed, 7 Aug 2002 17:09:35 -0400
Date: Wed, 7 Aug 2002 23:12:04 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andries.Brouwer@cwi.nl
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Marcin Dalecki <dalecki@evision.ag>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [bug, 2.5.29, (not IDE)] partition table (not) corruption?
In-Reply-To: <UTC200208071843.g77IhUc20546.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0208072309320.5699-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Aug 2002 Andries.Brouwer@cwi.nl wrote:

> LILO without "linear" or "lba32" is inherently broken: it will talk CHS
> at boot time to the BIOS and hence needs a geometry and install time,
> and nobody knows the geometry required. So, if LILO doesnt break, this
> is pure coincidence.

well, lilo without linear worked for like years on this box ...

> Since 2.5.30 many people will have a different geometry, so many people
> will have to find grub or a recent LILO, or add "linear" to their old
> LILO. This is all well understood - I just repeat it a few times in the
> hope that that will reduce the amount of email.
> 
> But now you talk about vanilla 2.5.29, and I am surprised. Could you
> send the kernel boot messages concerning that disk (dmesg | grep hd) for
> 2.5.28 and 2.5.29 and 2.5.30?

will do - it might have started in 2.5.28. But since i use the BK tree, i
might have tested an 'almost 2.5.30' 2.5.29 BK tree.

> And you talk about corruption, and I am surprised again. Have you
> verified that there really was a difference? Or do you only suspect
> corruption because LILO has problem? (In that case I can assure you that
> there was no corruption.)

you are right, there was no corruption most likely. And the IDE subsystem
is most definitely innocent.

	Ingo

