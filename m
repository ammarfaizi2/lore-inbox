Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267962AbRG2MUW>; Sun, 29 Jul 2001 08:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267964AbRG2MUN>; Sun, 29 Jul 2001 08:20:13 -0400
Received: from cabal.xs4all.nl ([213.84.101.140]:60946 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S267962AbRG2MT7>;
	Sun, 29 Jul 2001 08:19:59 -0400
Date: Sun, 29 Jul 2001 14:19:59 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Jean Charles Delepine <delepine@u-picardie.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        debian-devel@lists.debian.org, Herbert Xu <herbert@debian.org>,
        Manoj Srivastava <srivasta@debian.org>
Subject: Re: make rpm
Message-ID: <20010729141959.B19103@wiggy.net>
Mail-Followup-To: Jean Charles Delepine <delepine@u-picardie.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	debian-devel@lists.debian.org, Herbert Xu <herbert@debian.org>,
	Manoj Srivastava <srivasta@debian.org>
In-Reply-To: <E15QeJf-0008O8-00@the-village.bc.nu> <20010729135807.J8982@u-picardie.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010729135807.J8982@u-picardie.fr>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Previously Jean Charles Delepine wrote:
> Maybe Herbert Xu, the actual developper of the Debian kernel package or 
> Manoj Srivastava, for the Debian Linux kernel package build scripts can
> do that.

We've had that option for years, just call "make-kpkg kernel_image".
It would be trivial to add a rule to the Makefile in the kernel tree
that calls that if you do "make deb".

Wichert.

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
