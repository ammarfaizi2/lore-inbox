Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129688AbQKHAMq>; Tue, 7 Nov 2000 19:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129654AbQKHAMg>; Tue, 7 Nov 2000 19:12:36 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:32010 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129477AbQKHAM1>;
	Tue, 7 Nov 2000 19:12:27 -0500
Message-ID: <3A089A01.ECAEABBD@mandrakesoft.com>
Date: Tue, 07 Nov 2000 19:10:41 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
CC: kernel@kvack.org, Tigran Aivazian <tigran@veritas.com>,
        linux-kernel@vger.kernel.org, hpa@transmeta.com
Subject: Re: Installing kernel 2.4
In-Reply-To: <Pine.LNX.3.96.1001107175009.1482C-100000@kanga.kvack.org> <3A088C02.4528F66B@timpanogas.org> <3A0896F3.AB36C3EE@mandrakesoft.com> <3A0897F5.563552AD@timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:
> We need a format that allow multiple executable segments to be combined
> in a single executable and the loader have enough smarts to grab the
> right one based on architecture.  two options:
> 
> 1.  extend gcc to support this or rearragne linux into segments based on
> code type
> 2.  Use PE.

The kernel isn't going non-ELF.  Too painful, for dubious advantages,
namely:

The current gcc toolchain already supports what you suggest.

I understand that some people have even put some thought into a
bootloader that dynamically links your kernel on bootup, so this idea
isn't new.  It's a good idea though.

	Jeff


-- 
Jeff Garzik             | "When I do this, my computer freezes."
Building 1024           |          -user
MandrakeSoft            | "Don't do that."
                        |          -level 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
