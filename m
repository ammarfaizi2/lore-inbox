Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRA2U5g>; Mon, 29 Jan 2001 15:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130316AbRA2U50>; Mon, 29 Jan 2001 15:57:26 -0500
Received: from www.topmail.de ([212.255.16.226]:18852 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S129292AbRA2U5N> convert rfc822-to-8bit;
	Mon, 29 Jan 2001 15:57:13 -0500
Message-ID: <032601c08a36$0c8d5570$0100a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: "Torrey Hoffman" <torrey.hoffman@myrio.com>,
        "'Keith Owens'" <kaos@ocs.com.au>,
        "Matthew Pitts" <mpitts@suite224.net>
Cc: "Jacob Anawalt" <anawaltaj@qwest.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <4461B4112BDB2A4FB5635DE1995874320223F3@mail0.myrio.com>
Subject: Re: Knowing what options a kernel was compiled with 
Date: Mon, 29 Jan 2001 20:56:12 -0000
Organization: eccesys.net Linux Distribution Development
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Torrey Hoffman" <torrey.hoffman@myrio.com>
> Should someone submit a patch to copy the .config to a standard location as
> part of "make install" or "make modules_install"? If included in the
> official sources, that good example would encourage the distribution
> maintainers do the same. 
> 
> Torrey Hoffman

I dont do make install because it could do something unwanted.
modules_install isn't good either because some prefer monolithic
kernels. But split-include could do the job, as it's called as of 2.2
for each compile.

-mirabilos

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12+(proprietary extensions) # Updated:20010129 nick=mirabilos
GO/S d@ s--: a--- C++ UL++++ P--- L++$(-^lang) E----(joe) W+(++) loc=.de
N? o K? w-(+$) O+>+++ M-- V- PS+++@ PE(--) Y+ PGP t+ 5? X+ R+ !tv(silly)
b++++* DI- D+ G(>++) e(^age) h! r(-) y--(!y+) /* lang=NASM;GW-BASIC;C */
------END GEEK CODE BLOCK------


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
