Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130687AbQKHCSl>; Tue, 7 Nov 2000 21:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130899AbQKHCSb>; Tue, 7 Nov 2000 21:18:31 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:38157 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130687AbQKHCSP>; Tue, 7 Nov 2000 21:18:15 -0500
Message-ID: <3A08B7E1.604191BB@transmeta.com>
Date: Tue, 07 Nov 2000 18:18:09 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: "Jeff V. Merkey" <jmerkey@timpanogas.org>, kernel@kvack.org,
        Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
In-Reply-To: <Pine.LNX.3.96.1001107175009.1482C-100000@kanga.kvack.org> <3A088C02.4528F66B@timpanogas.org> <3A0896F3.AB36C3EE@mandrakesoft.com> <3A0897F5.563552AD@timpanogas.org> <3A089A01.ECAEABBD@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> "Jeff V. Merkey" wrote:
> > We need a format that allow multiple executable segments to be combined
> > in a single executable and the loader have enough smarts to grab the
> > right one based on architecture.  two options:
> >
> > 1.  extend gcc to support this or rearragne linux into segments based on
> > code type
> > 2.  Use PE.
> 
> The kernel isn't going non-ELF.  Too painful, for dubious advantages,
> namely:
> 
> The current gcc toolchain already supports what you suggest.
> 
> I understand that some people have even put some thought into a
> bootloader that dynamically links your kernel on bootup, so this idea
> isn't new.  It's a good idea though.
> 

Yes, I have been working on it on and off for a while ("off" due to
various professional and personal issues taking higher priority for some
time...)

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
