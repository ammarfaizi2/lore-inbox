Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132337AbRCZG0L>; Mon, 26 Mar 2001 01:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132338AbRCZGZv>; Mon, 26 Mar 2001 01:25:51 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15336 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132337AbRCZGZj>;
	Mon, 26 Mar 2001 01:25:39 -0500
Message-ID: <3ABEE0B5.12A2F768@mandrakesoft.com>
Date: Mon, 26 Mar 2001 01:24:53 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML1 cleanup patch
In-Reply-To: <200103260001.f2Q01Yt09387@snark.thyrsus.com> <15038.56527.591553.87791@wire.cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> [esr]
> > CONFIG_8139TOO                        CONFIG_RTL8139TOO
> > CONFIG_8139TOO_PIO            CONFIG_RTL8139TOO_PIO
> > CONFIG_8139TOO_TUNE_TWISTER   CONFIG_RTL8139TOO_TUNE_TWISTER
> 
> The -TOO suffix was to distinguish between this and the former 8139
> driver, as the two coexisted in 2.2 and 2.3.  As the old driver has
> been dropped from 2.4, I propose likewise dropping the -TOO.

It stays "8139too".  Donald Becker's rtl8139.c continues to exist
outside the kernel.  

And "rtl8139too" should have never crept into 2.2.  That needs to be
changed to "8139too."  That's what I get for saying that I don't support
2.2...

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
