Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272415AbRIOUJj>; Sat, 15 Sep 2001 16:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273013AbRIOUJ3>; Sat, 15 Sep 2001 16:09:29 -0400
Received: from fe000.worldonline.dk ([212.54.64.194]:28943 "HELO
	fe000.worldonline.dk") by vger.kernel.org with SMTP
	id <S272415AbRIOUJL>; Sat, 15 Sep 2001 16:09:11 -0400
Message-ID: <3BA23224.C105A0A6@eisenstein.dk>
Date: Fri, 14 Sep 2001 18:36:52 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AGP GART for AMD 761
In-Reply-To: <1000577021.32706.29.camel@phantasy> 
		<3BA22537.94D4EA28@eisenstein.dk> <1000582067.32708.51.camel@phantasy> 
		<3BA228EA.FCD61CA1@eisenstein.dk> <1000583357.32707.54.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

> On Fri, 2001-09-14 at 11:57, Jesper Juhl wrote:
> > bash-2.05# /sbin/lspci -n -v -s 0:0
> > 00:00.0 Class 0600: 1022:700e (rev 13)
>
> Thanks.  Ca you try the attached patch? It should fall back on
> try_unsupported if it can't find the 761.  Please send the relevant
> dmesg in reply.  Thank you.

Seems to work much better :

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected AMD 761 chipset
agpgart: AGP aperture is 64M @ 0xf8000000

Actually the previous patch may have worked as well, while trying to figure out why I couldn't
get it to apply I was playing around with the configuration and various other stuff and I may
accidentaly have disabled Irongate support in the kernel that I ended up building. I can retry
the original patch to verify that if you like.


Best regards,
Jesper Juhl
juhl@eisenstein.dk


