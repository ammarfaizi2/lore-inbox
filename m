Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263999AbRFFSke>; Wed, 6 Jun 2001 14:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264014AbRFFSkY>; Wed, 6 Jun 2001 14:40:24 -0400
Received: from anime.net ([63.172.78.150]:14087 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S263999AbRFFSkJ>;
	Wed, 6 Jun 2001 14:40:09 -0400
Date: Wed, 6 Jun 2001 11:39:12 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Marc Lehmann <pcg@goof.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Axel Thimm <Axel.Thimm@physik.fu-berlin.de>, Au-Ja <doelf@au-ja.de>,
        John R Lenton <john@grulic.org.ar>
Subject: Re: VIA's Southbridge bug: Latest (pseudo-)patch
In-Reply-To: <20010606182436.A9439@cerebro.laendle>
Message-ID: <Pine.LNX.4.30.0106061134220.353-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Marc Lehmann wrote:
> I *do* hate silent data corruption :()

An "integrity loopback" device would certainly detect silent corruption.

Eg a loopback which CRC's all blocks read/written and screams loudly if
the CRC fails.

-Dan

