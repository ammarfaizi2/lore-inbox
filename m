Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283723AbRLMJ1j>; Thu, 13 Dec 2001 04:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283756AbRLMJ1U>; Thu, 13 Dec 2001 04:27:20 -0500
Received: from [195.66.192.167] ([195.66.192.167]:7437 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S283723AbRLMJ1B>; Thu, 13 Dec 2001 04:27:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: pivot_root and initrd kernel panic woes
Date: Thu, 13 Dec 2001 11:22:20 -0200
X-Mailer: KMail [version 1.2]
Cc: Joy Almacen <joy@empexis.com>, wa@almesberger.net,
        linux-kernel@vger.kernel.org, "Stephen C. Tweedie" <sct@redhat.com>
In-Reply-To: <Pine.GSO.4.21.0112130319160.19281-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0112130319160.19281-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <01121311222003.01849@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 December 2001 06:19, Alexander Viro wrote:
> On Thu, 13 Dec 2001, vda wrote:
> > BTW, don't go for 2.4x, x>10. initrd is broken there and is still
> > unfixed.
>
> Bullshit.

I have a slackware initrd (minix) which is booting fine with 2.4.10
but fails to boot with 2.4.12 and later (same .config, same bootloader,
same hardware, same AC voltage in the wall outlet, time of day differs by
1 minute), so it might be true :-)

I have a report of romfs initrd with same symptoms. ext2 initrds OTOH
boots fine.
--
vda
