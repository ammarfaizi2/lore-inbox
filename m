Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317258AbSFLLs1>; Wed, 12 Jun 2002 07:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317266AbSFLLs0>; Wed, 12 Jun 2002 07:48:26 -0400
Received: from p50886B65.dip.t-dialin.net ([80.136.107.101]:32217 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317258AbSFLLsZ>; Wed, 12 Jun 2002 07:48:25 -0400
Date: Wed, 12 Jun 2002 05:47:22 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Thunder from the hill <thunder@ngforever.de>,
        Dave Jones <davej@suse.de>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        <linux-kernel@vger.kernel.org>, <chaffee@cs.berkeley.edu>
Subject: Re: [patch] fat/msdos/vfat crud removal
In-Reply-To: <m1n0u1uh16.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.44.0206120539090.24261-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12 Jun 2002, Eric W. Biederman wrote:
> > Eric W. Biederman wrote:
> > > Actually by now most applications have been fixed and do not use
> > > them.  The policy has been in place for several years now.

That means the possible policy of

#include <stdio.h>
#include <linux/version.h>

void exit(int code);

int main(void) {
    if (LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)) {
        fprintf(stderr, "Your kernel is too old!\n");
        exit(-127);
    }

    printf("Kernel version OK.\n");

    exit(0);
}

is impossible now after all, which is good, I think, because who said that 
the headers have to come from the _real_ _configured_ kernel? (It was way 
too crappy.)

Regards,
Thunder
-- 
German attitude becoming        |	Thunder from the hill at ngforever
rightaway popular:		|
       "Get outa my way,  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere

